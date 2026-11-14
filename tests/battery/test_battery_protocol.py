"""Exercise the actual protocol code on Windows using clang and llvmlite.

Run: python tests/battery/test_battery_protocol.py
Set TEST_CLANG to override the project PlatformIO clang executable.
"""
import binascii
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
for source in ['vesc_protocol', 'vesc_speed']:
    ir = build / (source + '_test.ll')
    subprocess.run([str(clang), '-target', 'x86_64-pc-windows-msvc', '-ffreestanding',
                    '-S', '-emit-llvm', '-O1', '-I', str(root / 'user'),
                    str(root / ('user/vesc/' + source + '.c')), '-o', str(ir)], check=True)
    module = llvm.parse_assembly(ir.read_text())
    module.triple = llvm.get_default_triple()
    engine.add_module(module)
engine.finalize_object()

class Parser(c.Structure):
    _fields_ = [('state', c.c_uint8), ('length', c.c_uint16), ('index', c.c_uint16),
                ('payload', c.c_uint8 * 17), ('crc', c.c_uint16), ('received_crc', c.c_uint16)]

class Telemetry(c.Structure):
    _fields_ = [('temp', c.c_int16), ('current', c.c_int32), ('rpm', c.c_int32),
                ('voltage', c.c_uint16)]

class Result(c.Structure):
    _fields_ = [('telemetry', Telemetry), ('speed', c.c_int32), ('level', c.c_int16)]

reset = c.CFUNCTYPE(None, c.POINTER(Parser))(engine.get_function_address('VescProtocol_Reset'))
feed = c.CFUNCTYPE(c.c_int, c.POINTER(Parser), c.c_uint8, c.POINTER(Result))(
    engine.get_function_address('VescProtocol_Feed'))
percent = c.CFUNCTYPE(c.c_uint8, c.c_int16)(engine.get_function_address('VescProtocol_BatteryPercent'))
request = c.CFUNCTYPE(None, c.POINTER(c.c_uint8))(engine.get_function_address('VescProtocol_RequestSetup'))
speed_kmh = c.CFUNCTYPE(c.c_int16, c.c_int32)(engine.get_function_address('VescSpeed_FromMmPerSecond'))

def frame(payload, damage_crc=False):
    crc = binascii.crc_hqx(payload, 0) ^ damage_crc
    return bytes([2, len(payload)]) + payload + crc.to_bytes(2, 'big') + bytes([3])

def run(parser, payload):
    result = Result()
    events = [feed(c.byref(parser), byte, c.byref(result)) for byte in payload]
    return events, result

request_bytes = (c.c_uint8 * 10)()
request(request_bytes)
assert bytes(request_bytes) == frame(bytes([51, 0, 0, 1, 64]))
for value, expected in [(0, 0), (1000, 4), (-1000, -4), (10000, 36), (-10000, -36),
                        (138, 0), (139, 1), (-139, -1),
                        (2147483647, 32767), (-2147483648, -32768)]:
    assert speed_kmh(value) == expected
for value, expected in [(-20, 0), (0, 0), (9, 0), (199, 19), (200, 20),
                        (750, 75), (999, 99), (1000, 100), (1200, 100)]:
    assert percent(value) == expected

p = Parser()
reset(c.byref(p))
for speed, value in [(0, 0), (10000, 750), (-10000, 199), (2147483647, 1000),
                     (-2147483648, -20), (12345, 1200)]:
    payload = bytes([51, 0, 0, 1, 64]) + speed.to_bytes(4, 'big', signed=True) + value.to_bytes(2, 'big', signed=True)
    events, result = run(p, frame(payload))
    assert events[-1] == 2 and result.level == value and result.speed == speed
    assert not any(run(p, frame(payload, True))[0])

assert not any(run(p, frame(bytes([51, 0, 0, 1, 0, 0, 0, 0, 0, 2, 238])))[0])  # wrong mask
assert not any(run(p, frame(bytes([52, 0, 0, 1, 64, 0, 0, 0, 0, 2, 238])))[0])  # wrong command
assert not any(run(p, frame(bytes([51, 0, 0, 1, 64, 0, 0, 0, 0, 2])))[0])       # truncated
telemetry = bytes([50, 0, 0, 1, 137, 0, 250, 0, 0, 0, 123,
                   0, 0, 3, 232, 1, 244])
events, result = run(p, frame(telemetry))
assert events[-1] == 1
assert (result.telemetry.temp, result.telemetry.current, result.telemetry.rpm,
        result.telemetry.voltage) == (250, 123, 1000, 500)
print('VESC setup request, speed, battery, telemetry and rejection passed.')
