import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.binary import BinaryValue

@cocotb.test()
async def test1(dut):
    clock = Clock(dut.clk_wr,1,'ns')
    cocotb.start_soon(clock.start())

    inp = BinaryValue("00000000",n_bits=8,bigEndian=True)
    dut.inp_wr.value = inp
    await Timer(10,'ns')
    output_f1 = dut.field1.value
    output_f2 = dut.field2.value
    assert output_f1 == inp[0:6], f"field1 is {output_f1} expected {inp[0:6]}"
    assert output_f2 == inp[7], f"field2 is {output_f2} expected {inp[7]}"
