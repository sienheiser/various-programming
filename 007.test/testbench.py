# test_sample.py
import cocotb
from cocotb.triggers import RisingEdge, ClockCycles, Timer, FallingEdge
from cocotb.clock import Clock

@cocotb.test()
async def type_test(dut):
    # Reading
    print(dut.rec.a)

    # Writing
    dut.rec.a = 0

    await Timer(1, 'step')

    assert dut.rec.a == 0, "rec.a was not updated"
