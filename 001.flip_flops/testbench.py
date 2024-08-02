import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def test1(dut):
    clock = Clock(dut.clk,1,'ns')
    dut.D.value = 1
    cocotb.start_soon(clock.start())
    await Timer(1,'ns') #load D
    await Timer(1,'ns') #load Q
    
    assert dut.D.value == dut.Q.value, "The input does not equal the output"

