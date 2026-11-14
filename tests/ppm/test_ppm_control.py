"""Exercise PPM mixing, pulse conversion and arming/fault state on Windows.

Requires llvmlite and the PlatformIO clang toolchain (or TEST_CLANG override).
Run: python tests/ppm/test_ppm_control.py
"""
import ctypes as c
import os
import pathlib
import subprocess
from llvmlite import binding as llvm

root = pathlib.Path(__file__).resolve().parents[2]
clang = pathlib.Path(os.environ.get('TEST_CLANG', str(pathlib.Path.home() / '.platformio' /
    'packages/toolchain-agrv-clang/bin/riscv64-unknown-elf-cc.exe')))
build = root / '.pio' / 'build'
build.mkdir(parents=True, exist_ok=True)
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()
machine = llvm.Target.from_default_triple().create_target_machine()
engine = llvm.create_mcjit_compiler(llvm.parse_assembly(''), machine)
for name in ['ppm_mix', 'ppm_control']:
    ir = build / (name + '_test.ll')
    subprocess.run([str(clang), '-target', 'x86_64-pc-windows-msvc', '-ffreestanding',
                    '-S', '-emit-llvm', '-O1', '-I', str(root / 'user'),
                    str(root / ('user/ppm/' + name + '.c')), '-o', str(ir)], check=True)
    module = llvm.parse_assembly(ir.read_text())
    module.triple = llvm.get_default_triple()
    engine.add_module(module)
engine.finalize_object()

class Control(c.Structure):
    _fields_ = [('state', c.c_int), ('neutral_tracking', c.c_bool), ('neutral_since', c.c_uint32)]

step = c.CFUNCTYPE(c.c_float, c.POINTER(Control), c.c_uint32, c.c_bool, c.c_bool,
                   c.c_bool, c.c_float, c.c_float)(engine.get_function_address('PpmControl_Update'))
pulse = c.CFUNCTYPE(c.c_uint16, c.c_float)(engine.get_function_address('Ppm_PulseWidthUs'))
normalize = c.CFUNCTYPE(c.c_float, c.c_uint16, c.c_uint16, c.c_uint16)(
    engine.get_function_address('Ppm_NormalizeAdc'))
assert [pulse(v) for v in [-2, -1, -0.5, 0, 0.5, 1, 2]] == [1000, 1000, 1250, 1500, 1750, 2000, 2000]
assert [normalize(v, 1000, 2000) for v in [0, 1000, 1500, 2000, 4095]] == [0, 0, 0.5, 1, 1]
assert normalize(999, 1000, 2000) == 0 and normalize(2001, 1000, 2000) == 1

ctrl = Control()
assert step(c.byref(ctrl), 0, False, True, False, 1, 0) == 0 and ctrl.state == 0
assert step(c.byref(ctrl), 10000, False, True, False, 1, 0) == 0 and ctrl.state == 0
assert step(c.byref(ctrl), 10001, False, True, True, 0, 0) == 0
assert step(c.byref(ctrl), 11000, False, True, True, 0, 0) == 0 and ctrl.state == 0
assert step(c.byref(ctrl), 11001, False, True, True, 0, 0) == 0 and ctrl.state == 1
assert step(c.byref(ctrl), 11002, False, True, False, 0.5, 0) == 0.5
assert step(c.byref(ctrl), 11002, False, True, False, normalize(4095, 1000, 2000), 0) == 1
assert step(c.byref(ctrl), 11003, False, True, False, 0, 1) == -1
assert step(c.byref(ctrl), 11004, True, True, False, 1, 0) == 0 and ctrl.state == 0
assert step(c.byref(ctrl), 11005, False, True, False, 1, 0) == 0 and ctrl.state == 0

ctrl = Control()
step(c.byref(ctrl), 0, False, True, True, 0, 0)
step(c.byref(ctrl), 1000, False, True, True, 0, 0)
assert ctrl.state == 1
assert step(c.byref(ctrl), 1001, False, False, False, 1, 0) == 0 and ctrl.state == 2
assert step(c.byref(ctrl), 100000, False, True, True, 1, 0) == 0 and ctrl.state == 2

ctrl = Control()
step(c.byref(ctrl), 0xffffff00, False, True, True, 0, 0)
step(c.byref(ctrl), 744, False, True, True, 0, 0)
assert ctrl.state == 1  # tick rollover preserves the one-second delay
print('PPM arming, lock, latched faults, mixing and pulse mapping passed.')
