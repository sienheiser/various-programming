import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock  
from cocotb.binary import BinaryValue

@cocotb.test()
async def test1(dut):
    clock = Clock(dut.clk,1,'ns')
    cocotb.start_soon(clock.start())
    result = {"001":"00000000",
              "010":"00000001",
              "100":"00000010",
              "111":"00000011",
              "011":"00000011",
              "101":"00000011",}
    
    for input in result.keys():
        dut.inp.value = BinaryValue(input,n_bits=3,bigEndian=False)
        await Timer(2,'ns')
        assert dut.enc.value == BinaryValue(result[input],n_bits=8,bigEndian=False), f"The output {dut.enc.value} is not S_OK"
       

