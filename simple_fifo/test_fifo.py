import json
import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from dataclasses import dataclass, field


@cocotb.test()
async def test_fifo(dut):
    filename = "trace-1779453094.json"
    contexts = read_trace(filename)

    clock = Clock(dut.i_clk,1,'ns')
    cocotb.start_soon(clock.start())

     # DUT state persists across all actions below
    for action_name, context, ctx_id, trace_id in contexts:

        dut._log.info(
            f"Running trace={trace_id} ctx={ctx_id} action={action_name}"
        )


        if action_name == "Init":
            await init_fifo_state(dut, context)
        else:
            await next_fifo_state(dut, context)

        print_fifo_state(dut, context)


        assert_fifo_state(dut, context)


@dataclass
class FifoState:
    i_store:   int = -999
    i_data:    int = -999
    i_read:    int = -999
    o_data:    int = -999
    o_full:    int = -999
    o_empty:   int = -999
    fifo_data: list = field(default_factory=list)


async def init_fifo_state(dut, context):
    dut.i_store.value = context["i_store"]
    dut.i_data.value = context["i_data"]
    dut.i_read.value = context["i_read"]
    await Timer(2, "ns")

    dut.i_rst.value = 1
    await Timer(2, "ns")

    dut.i_rst.value = 0
    await Timer(2, "ns")

    dut.i_store.value = 1
    dut.i_data.value = context["i_data"]
    dut.i_read.value = context["i_read"]
    await Timer(2, "ns")

    dut.i_store.value = 0
    dut.i_read.value = 1
    await Timer(2, "ns")

    dut.i_read.value = 0
    await Timer(2, "ns")

    dut.i_rst.value = 1
    await Timer(2, "ns")

    dut.i_rst.value = 0
    await Timer(2, "ns")


async def next_fifo_state(dut, context):
    dut.i_store.value = context["i_store"]
    dut.i_data.value  = context["i_data"]
    dut.i_read.value  = context["i_read"]
    await Timer(1, "ns")
    dut._log.info(f"i_store={context["i_store"]}")

def assert_fifo_state(dut,context):
    model_state = get_model_state(context)
    dut_state = get_dut_state(dut)
    for field_name in model_state.__dataclass_fields__:
        if field_name == "fifo_data":
            expected = len(getattr(model_state, field_name))
            result = dut.count.value
            msg = f"for {field_name=} the number of elements do not match between {expected=}, {result=}"
            assert expected == result, msg
        else:
            expected = getattr(model_state, field_name)
            result = getattr(dut_state, field_name)
            msg = f"for {field_name=} {expected=} {result=}"
            assert  expected == result, msg

def print_fifo_state(dut, context):
    dut_state = get_dut_state(dut)
    model_state = get_model_state(context)

    model_str = "-----------------------------------------model--------------------------------\n"
    model_str += f"i_store = {model_state.i_store}|        |o_full = {model_state.o_full}\n"
    model_str += f"i_read  = {model_state.i_read}| q = {model_state.fifo_data} |o_empty = {model_state.o_empty}\n"
    model_str += f"i_data  = {model_state.i_data}|        |o_data = {model_state.o_data}\n"

    dut_str = "-----------------------------------------dut--------------------------------\n"
    dut_str += f"i_store = {dut_state.i_store}| wr_ptr = {convert_to_int(dut.wr_ptr)}, rd_ptr = {convert_to_int(dut.rd_ptr)}       |o_full = {dut_state.o_full}\n"
    dut_str += f"i_read  = {dut_state.i_read}| q = {dut_state.fifo_data} |o_empty = {dut_state.o_empty}\n"
    dut_str += f"i_data  = {dut_state.i_data}| count = {convert_to_int(dut.count)}       |o_data = {dut_state.o_data}\n"

    dut._log.info(
        model_str
    )
    dut._log.info(
        dut_str
    )


def get_dut_state(dut)->FifoState:
    i_store = convert_to_int(dut.i_store)
    i_data = convert_to_int(dut.i_data)
    i_read = convert_to_int(dut.i_read)
    o_data = convert_to_int(dut.o_data)
    o_full = convert_to_int(dut.o_full)
    o_empty = convert_to_int(dut.o_empty)
    fifo_data = [convert_to_int(dut.mem_dbg0),convert_to_int(dut.mem_dbg1),convert_to_int(dut.mem_dbg2)]
    return FifoState(
        i_store=i_store, i_data=i_data, i_read=i_read,
        o_data=o_data, o_full=o_full, o_empty=o_empty,
        fifo_data=fifo_data
    )

def get_model_state(context)->FifoState:
    i_store = context["i_store"]
    i_data = context["i_data"]
    i_read = context["i_read"]
    o_data = context["o_data"]
    o_full = context["o_full"]
    o_empty = context["o_empty"]
    fifo_data = context["fifo_data"]
    return FifoState(
        i_store=i_store, i_data=i_data, i_read=i_read,
        o_data=o_data, o_full=o_full, o_empty=o_empty,
        fifo_data=fifo_data
    )

    

def read_trace(filename:str)->list[(str,dict,int,int)]:
    with open(filename,"r") as file:
        traces = json.load(file)

    contexts = []
    for i, trace in enumerate(traces):
        for j ,context in enumerate(trace):
            contexts.append((get_action_name(context),context,j,i))
    return contexts

def convert_to_int(val:...)->int:
    try:
        return int(val.value)
    except:
        return -999


def get_action_name(context:dict)->str:
    return context["_action"]["name"]