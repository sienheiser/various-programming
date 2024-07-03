import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue
from cocotb.clock import Clock

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk_wr,1,'ns')
    cocotb.start_soon(clock.start())

    await Timer(6,'ns')
    output1 = dut.out1_wr.value
    output2 = dut.out2_wr.value
    expected1 = BinaryValue("00000001",n_bits=8,bigEndian=False)
    expected2 = BinaryValue("00000001",n_bits=8,bigEndian=False)

    assert expected1 == output1, f"expected1={expected1},output1={output1}"





    
