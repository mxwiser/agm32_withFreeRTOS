"""Build the project's custom MCU/FPGA logic with the AGM Native toolchain."""

import argparse
import configparser
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys


QUARTUS_HEADER = r'''
# AGM_QUARTUS_GUARD: added by build_logic.bat after project generation.
set agm_version [exec [file join $::quartus(binpath) quartus_sh] --version 2>@1]
if {[regexp -nocase {Lite Edition} $agm_version]} {
  error "AG32 requires preserved MCU design partitions. Quartus Lite removes them (138067). Use a supported licensed edition, or run build_logic.bat for Native synthesis."
}
'''

QUARTUS_RESULT_CHECK = r'''
# AGM_QUARTUS_RESULT_GUARD
if {!$is_compatible && $code != 0} {
  error "Quartus compilation failed: $msg"
}
set agm_report [file join quartus_logs ${DESIGN}.flow.rpt]
if {![file exists $agm_report]} {
  error "Quartus flow report is missing; no verified netlist was generated."
}
set agm_fp [open $agm_report r]
set agm_text [read $agm_fp]
close $agm_fp
if {![regexp {Total PLLs\s*;\s*([0-9]+)} $agm_text -> agm_plls] || $agm_plls < 1} {
  error "AG32 PLL was removed during synthesis. Do not compile or upload this Quartus netlist."
}
'''

SUPRA_CHECK = r'''
# AGM_QUARTUS_NETLIST_GUARD_BEGIN
if {[info exists MODE] && $MODE == "QUARTUS"} {
  set agm_report [file join quartus_logs ${DESIGN}.flow.rpt]
  if {![file exists $agm_report]} {
    error "Quartus flow report missing. Run af_quartus.tcl, or use build_logic.bat."
  }
  set agm_fp [open $agm_report r]
  set agm_text [read $agm_fp]
  close $agm_fp
  if {![regexp {Total PLLs\s*;\s*([0-9]+)} $agm_text -> agm_plls] || $agm_plls < 1} {
    error "Quartus removed the AG32 PLL. This netlist cannot boot the MCU. Use a supported licensed Quartus edition, or build_logic.bat."
  }
}
# AGM_QUARTUS_NETLIST_GUARD_END
'''


def run(command, cwd, environment, log_path):
    with log_path.open("w", encoding="utf-8") as log:
        result = subprocess.run(
            [str(arg) for arg in command], cwd=cwd, env=environment,
            stdout=log, stderr=subprocess.STDOUT, check=False)
    output = log_path.read_text(encoding="utf-8", errors="replace")
    if result.returncode or re.search(r"(?:^|\n)(?:Error:|Fatal:|application-specific initialization failed:)", output):
        print(output[-8000:])
        raise RuntimeError(f"Command failed. Log: {log_path}")
    return output


def install_quartus_checks(logic_dir, design):
    script = logic_dir / "af_quartus.tcl"
    text = script.read_text(encoding="utf-8")
    if "AGM_QUARTUS_GUARD" not in text:
        script.write_text(QUARTUS_HEADER.lstrip() + text + QUARTUS_RESULT_CHECK,
                          encoding="utf-8")
    pre_script = logic_dir / f"{design}.pre.asf"
    text = pre_script.read_text(encoding="utf-8")
    text = re.sub(r"\n?# AGM_QUARTUS_NETLIST_GUARD_BEGIN.*?# AGM_QUARTUS_NETLIST_GUARD_END\n?",
                  "", text, flags=re.DOTALL)
    pre_script.write_text(text.rstrip() + "\n" + SUPRA_CHECK, encoding="utf-8")


def select_sources(logic_dir, design, ip_name):
    # Re-reading a routed top or an IP template with -overwrite replaces the
    # real design. Include user RTL such as ahb2apb.v, but exclude these outputs.
    sources = [f"{design}.v", f"{ip_name}.v"]
    sources += sorted(path.name for path in logic_dir.glob("*.v")
                      if path.name not in sources and
                      not path.name.endswith(("_routed.v", "_tmpl.v")))
    mapping = logic_dir / "af_map.tcl"
    text = mapping.read_text(encoding="utf-8")
    source_list = " ".join("{" + source + "}" for source in sources)
    text = re.sub(r'(?m)^(\s*)set verilogs \{ "[^\n]+\}\s*$',
                  lambda match: match[1] + "set verilogs { " + source_list + " }", text)
    mapping.write_text(text, encoding="utf-8")
    qsf = logic_dir / f"{design}.qsf"
    lines = qsf.read_text(encoding="utf-8").splitlines()
    qsf.write_text("\n".join(line for line in lines
                             if not (line.lstrip().startswith("set_global_assignment -name VERILOG_FILE ")
                                     and ("_routed.v" in line or "_tmpl.v" in line))) + "\n",
                   encoding="utf-8")
    return sources


def build(tool_home):
    root = Path(__file__).resolve().parents[1]
    config = configparser.ConfigParser(interpolation=None, inline_comment_prefixes=("#", ";"))
    config.read(root / "platformio.ini", encoding="utf-8-sig")
    settings = config["setup_logic"]
    ve = root / settings["board_logic.ve"].strip()
    design = ve.stem
    device = settings["board_logic.device"].strip()
    logic_dir = root / settings["logic_dir"].strip().rstrip("+-")
    ip_name = settings["ip_name"].strip()
    board = config["setup"]["board"].strip()
    sdk = tool_home.parents[1] / "platforms" / "AgRV" / "etc"
    python = tool_home / "python_dist" / "python.exe"
    yosys = tool_home / "map" / "bin" / "yosys.exe"
    supra = tool_home / "bin" / "af.exe"
    for path in (ve, python, yosys, supra, sdk / "gen_vlog", sdk / "pre_logic.tcl"):
        if not path.is_file():
            raise RuntimeError(f"Required file not found: {path}")
    logic_dir.mkdir(parents=True, exist_ok=True)
    result_dir = root / ".pio" / "native_logic_build"
    result_dir.mkdir(parents=True, exist_ok=True)
    environment = os.environ.copy()
    environment.pop("ALTA_HOME", None)
    environment["TCL_LIBRARY"] = str(tool_home / "lib" / "tcl8.6")
    environment["PATH"] = os.pathsep.join((str(yosys.parent), str(supra.parent), environment.get("PATH", "")))

    print(f"Project: {board}, {device}; design: {design}", flush=True)
    print("[1/4] Generate MCU/FPGA top, pin map and clock header", flush=True)
    run([python, sdk / "gen_vlog", "-c", logic_dir / f"{design}.hx", "-s", "-d", device,
         "-x", logic_dir / f"{design}.vex", ve, logic_dir / f"{design}.v",
         "-m", logic_dir / f"{ip_name}.v"], root, environment, result_dir / "generate.log")

    print("[2/4] Prepare the custom logic project", flush=True)
    variables = {
        "LOGIC_DEVICE": device, "LOGIC_DESIGN": design, "LOGIC_TOPPIN": "False",
        "LOGIC_DIR": logic_dir.as_posix(), "LOGIC_VV": f"{design}.v",
        "BOARD_ASF": (root / settings.get("board_logic.asf", f"sdk/{board}/board.asf")).as_posix(),
        "BOARD_PRE": "", "BOARD_POST": "", "DESIGN_ASF": "", "DESIGN_PRE": "", "DESIGN_POST": "",
        "LOGIC_FORCE": "false", "VEX_FILE": f"{design}.vex", "ATF_FILE": "", "SDC_FILE": "",
        "IP_VV": f"{ip_name}.v", "LIB_DIRS": ".", "ORIGINAL_PIN": "-",
    }
    for option, variable in (("design.asf", "DESIGN_ASF"), ("design.pre_asf", "DESIGN_PRE"), ("design.post_asf", "DESIGN_POST")):
        if settings.get(option, "").strip():
            variables[variable] = (root / settings[option].strip()).as_posix()
    if settings.getboolean("board_logic.compress", fallback=False):
        variables["LOGIC_COMPRESS"] = "true"
    command = [supra, "-L", result_dir / "prepare_commands.log"]
    for key, value in variables.items():
        command += ["-X", f"set {key} {{{value}}}"]
    command += ["-F", sdk / "pre_logic.tcl"]
    run(command, root, environment, result_dir / "prepare.log")
    sources = select_sources(logic_dir, design, ip_name)
    install_quartus_checks(logic_dir, design)

    print("[3/4] Yosys synthesis (AGM Native)", flush=True)
    run([yosys, "-TQd", "-v", "1", "-L", result_dir / "yosys_details.log", "-c", "af_map.tcl", *sources],
        logic_dir, environment, result_dir / "synthesis.log")
    print("[4/4] Supra Native placement, routing and bitstream generation", flush=True)
    output = run([supra, "-X", f"set RESULT_DIR {{{result_dir.as_posix()}}}",
                  "--batch", "--mode", "NATIVE", "--flow", "ALL"],
                 logic_dir, environment, result_dir / "route.log")
    if not re.search(r"Total\s+PLLs\s*:\s*1\s*/", output):
        raise RuntimeError("PLL missing from Native result; bitstream was not published.")
    routed = (result_dir / f"{design}_routed.v").read_text(encoding="utf-8")
    if not re.search(r"\balta_rv32\s+\S+\s*\(", routed):
        raise RuntimeError("MCU interface missing from Native result; bitstream was not published.")
    binary = result_dir / f"{design}.bin"
    if not binary.is_file() or not 0 < binary.stat().st_size <= 100 * 1024:
        raise RuntimeError("Missing or oversized LOGIC bitstream; result was not published.")
    for suffix in (".bin", ".inc", "_routed.v"):
        shutil.copy2(result_dir / f"{design}{suffix}", logic_dir / f"{design}{suffix}")
    print(f"SUCCESS: {logic_dir / (design + '.bin')} ({binary.stat().st_size} bytes)")
    print("Verified: 1 PLL and MCU interface retained. Next: PlatformIO Upload LOGIC.")
    print(f"Logs: {result_dir}")


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tool-home", required=True, type=Path)
    arguments = parser.parse_args()
    try:
        build(arguments.tool_home.resolve())
    except (OSError, KeyError, ValueError, RuntimeError, configparser.Error) as error:
        print(f"ERROR: {error}")
        sys.exit(1)
