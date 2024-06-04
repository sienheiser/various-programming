import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.binary import BinaryValue

@cocotb.test()
async def test1(dut):
    clock = Clock(dut.clk,1,'ns')
    cocotb.start_soon(clock.start())

    inp = BinaryValue("00000000",n_bits=8,bigEndian=False)
    dut.inp.value = inp
    await Timer(2,'ns')
    output_f1 = dut.outp.field1.value
    output_f2 = dut.outp.field2.value
    assert output_f1 == inp[0:6], f"field1 is {output_f1} expected {inp[0:6]}"
    assert output_f2 == inp[7], f"field2 is {output_f2} expected {inp[7]}"
