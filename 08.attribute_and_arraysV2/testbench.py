import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.binary import BinaryValue

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk_wr,1,'ns')
    cocotb.start_soon(clock.start())
    dut.inpa_wr.value = BinaryValue("00000001",n_bits=8,bigEndian=False)
    dut.inpb_wr.value = BinaryValue("00000001",n_bits=8,bigEndian=False)
    
    await Timer(8, 'ns')

    expected1 = BinaryValue("00000001",n_bits=8,bigEndian=False)
    expected2 = BinaryValue("00000001",n_bits=8,bigEndian=False)

    out1 = dut.out1_wr.value
    out2 = dut.out2_wr.value

    assert expected1 == out1, f"expected1 = {expected1}, out1 = {out1}"
    assert expected2 == out2, f"expected2 = {expected2}, out2 = {out2}"

