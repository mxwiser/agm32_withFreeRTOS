import ctypes as c
import binascii
import pathlib
import subprocess
import os
from llvmlite import binding as llvm

root = pathlib.Path(__file__).resolve().parents[2]
os.chdir(root)
# Set TEST_CLANG to a clang binary; the project PlatformIO toolchain is the default.
clang = pathlib.Path(os.environ.get('TEST_CLANG', str(pathlib.Path.home() / '.platformio' /
    'packages/toolchain-agrv-clang/bin/riscv64-unknown-elf-cc.exe')))
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()
machine = llvm.Target.from_default_triple().create_target_machine()
engine = llvm.create_mcjit_compiler(llvm.parse_assembly(''), machine)
(root / '.pio' / 'build').mkdir(parents=True, exist_ok=True)
for source in ['user/battery.c', 'user/vesc/vesc_protocol.c']:
    ir = root / '.pio' / 'build' / (pathlib.Path(source).stem + '_test.ll')
    subprocess.run([str(clang), '-target', 'x86_64-pc-windows-msvc', '-ffreestanding',
                    '-S', '-emit-llvm', '-O1', '-I', 'user', source, '-o', str(ir)], check=True)
    module = llvm.parse_assembly(ir.read_text())
    module.triple = llvm.get_default_triple()
    engine.add_module(module)
engine.finalize_object()

estimate = c.CFUNCTYPE(c.c_uint8, c.c_uint16, c.c_uint8, c.c_uint8)(engine.get_function_address('Battery_EstimatePercent'))
supported = c.CFUNCTYPE(c.c_bool, c.c_uint8)(engine.get_function_address('Battery_IsTypeSupported'))
for voltage, cells, kind, expected in [(546,13,0,100),(481,13,0,20),(525,13,0,78),
    (416,16,1,0),(496,16,1,50),(576,16,1,100),(252,12,2,0),(284,12,2,100),
    (500,0,0,0),(500,13,255,0)]:
    assert estimate(voltage,cells,kind) == expected, (voltage,cells,kind)
assert all(supported(i) for i in range(3)) and not supported(3)
for kind in range(3):
    values = [estimate(v,13,kind) for v in range(1500)]
    assert values == sorted(values) and max(values) <= 100

class Parser(c.Structure):
    _fields_ = [('state',c.c_uint8),('length',c.c_uint16),('index',c.c_uint16),
        ('payload',c.c_uint8*17),('crc',c.c_uint16),('received_crc',c.c_uint16),
        ('cells_502',c.c_uint8),('cells_503',c.c_uint8),('cells_600',c.c_uint8),('cells_701',c.c_uint8),
        ('type_502',c.c_uint8),('type_503',c.c_uint8),('type_600',c.c_uint8),('type_701',c.c_uint8)]
class Telemetry(c.Structure):
    _fields_ = [('temp',c.c_int16),('current',c.c_int32),('rpm',c.c_int32),('voltage',c.c_uint16)]
class Result(c.Structure):
    _fields_ = [('telemetry',Telemetry),('signature',c.c_uint32),('cells',c.c_uint8),
                ('kind',c.c_uint8),('supported',c.c_bool)]
reset = c.CFUNCTYPE(None,c.POINTER(Parser))(engine.get_function_address('VescProtocol_Reset'))
feed = c.CFUNCTYPE(c.c_int,c.POINTER(Parser),c.c_uint8,c.POINTER(Result))(engine.get_function_address('VescProtocol_Feed'))
def check(sig, size, offset, kind, cells, bad_crc=False):
    payload = bytearray(size)
    payload[0] = 14
    payload[1:5] = sig.to_bytes(4,'big')
    payload[offset-1:offset+1] = bytes((kind,cells))
    crc = binascii.crc_hqx(payload,0) ^ bad_crc
    frame = b'\x03' + size.to_bytes(2,'big') + payload + crc.to_bytes(2,'big') + b'\x03'
    p, result = Parser(), Result()
    reset(c.byref(p))
    events = [feed(c.byref(p), b, c.byref(result)) for b in frame]
    if bad_crc:
        assert not any(events)
    else:
        assert events[-1] == 2 and result.supported and result.cells == cells and result.kind == kind
for sig,size,offset in [(2211848314,458,444),(2525666056,485,466),(776184161,482,462),(471314414,493,467)]:
    for kind in range(3): check(sig,size,offset,kind,13)
    check(sig,size,offset,2,13,True)
payload = bytearray(458)
payload[0] = 14
payload[1:5] = (123).to_bytes(4, 'big')
crc = binascii.crc_hqx(payload, 0)
frame = b'\x03' + len(payload).to_bytes(2, 'big') + payload + crc.to_bytes(2, 'big') + b'\x03'
p, result = Parser(), Result()
reset(c.byref(p))
for byte in frame:
    event = feed(c.byref(p), byte, c.byref(result))
assert event == 2 and not result.supported and result.cells == 0
print('Battery estimation and VESC configuration frames passed.')
