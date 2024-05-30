import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.binary import BinaryValue

@cocotb.test()
async def test1(dut):
    clock = Clock(dut.clk,1,'ns')
    cocotb.start_soon(clock.start())

    dut.inp.value = BinaryValue('100',n_bits = 3,bigEndian=False)
    await Timer(2,'ns')
    assert dut.r.value == 1 and dut.g.value == 0 and dut.b.value == 0, "failed on case 1"

    dut.inp.value = BinaryValue('010',n_bits = 3,bigEndian=False)
    await Timer(2,'ns')
    assert dut.r.value == 0 and dut.g.value == 1 and dut.b.value == 0, "failed on case 2"

    dut.inp.value = BinaryValue('001',n_bits = 3,bigEndian=False)
    await Timer(2,'ns')
    assert dut.r.value == 0 and dut.g.value == 0 and dut.b.value == 1, "failed on case 3"

    dut.inp.value = BinaryValue('000',n_bits = 3,bigEndian=False)
    await Timer(2,'ns')
    assert dut.r.value == 0 and dut.g.value == 0 and dut.b.value == 0, "failed on case 4"
