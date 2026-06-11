import json
import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from dataclasses import dataclass, field

@cocotb.test()
async def test_fifo(dut):
    # ...
    filename = "trace-1779279885.json"
    with open(filename,"r") as file:
        traces = json.load(file)

    contexts = []
    for i, trace in enumerate(traces):
        for j ,context in enumerate(trace):
            contexts.append((get_action_name(context),context,j,i))

    clock = Clock(dut.clk,1,'ns')
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
        
        # print_fifo_state(dut,context)
        # print_channel_state(dut)

        assert_fifo_state(dut, context)


async def init_fifo_state(dut, context:dict)->None:
    dut.i_wr_en.value = 1
    dut.i_wr_q_en.value = context["i_rd_q_en"]
    dut.i_rd_q_en.value = context["i_rd_q_en"]
    dut.i_rd_en.value = context["i_rd_en"]
    dut.i_wr_data.value = context["i_data"]
    dut.rst.value = 0
    await Timer(2, 'ns')
    print_channel_state(dut)

    dut.i_wr_en.value = 0
    dut.i_wr_q_en.value = 1
    await Timer(2, 'ns')
    print_channel_state(dut)

    dut.i_wr_q_en.value = 0
    await Timer(2, 'ns')
    print_channel_state(dut)

    dut.i_rd_q_en.value = 1
    await Timer(2, 'ns')
    print_channel_state(dut)

    dut.i_rd_q_en.value = 0
    dut.i_rd_en.value = 1
    await Timer(2, "ns")
    print_channel_state(dut)

    dut.i_rd_en.value = 0
    await Timer(2, "ns")
    return None



async def next_fifo_state(dut,context:dict)->None:
    dut.i_wr_en.value = context["i_wr_en"]
    dut.i_wr_q_en.value = context["i_wr_q_en"]
    dut.i_rd_en.value = context["i_rd_en"]
    dut.i_rd_q_en.value = context["i_rd_q_en"]
    dut.i_wr_data.value = context["i_data"]
    await Timer(2, "ns")

def assert_fifo_state(dut,context:dict)->None:
    i_wr_en_exp = context["i_wr_en"]
    i_wr_en_res = convert_to_int(dut.i_wr_en)
    i_wr_q_en_exp = context["i_wr_q_en"]
    i_wr_q_en_res = convert_to_int(dut.i_wr_q_en)

    i_rd_en_exp = context["i_rd_en"]
    i_rd_en_res = convert_to_int(dut.i_rd_en)
    i_rd_q_en_exp = context["i_rd_q_en"]
    i_rd_q_en_res = convert_to_int(dut.i_rd_q_en)
    
    i_wr_data_exp = context["i_data"]
    i_wr_data_res = convert_to_int(dut.i_wr_data)

    interface_1_exp = context["interface_1"]
    interface_1_res = convert_to_int(dut.interface_data_1)

    q_exp = context["q"]
    
    q_res = []
    q_res.reverse()
    q_res = q_res[:len(q_exp)]

    interface_2_exp = context["interface_2"]
    interface_2_res = convert_to_int(dut.interface_data_2)


    o_full_exp = context["o_full"]
    o_full_res = convert_to_int(dut.o_full)

    o_empty_exp = context["o_empty"]
    o_empty_res = convert_to_int(dut.o_empty)

    o_rd_data_exp = context["o_data"]
    o_rd_data_res = convert_to_int(dut.o_rd_data)


    expectations = [i_wr_en_exp, i_wr_q_en_exp, i_rd_en_exp, i_rd_q_en_exp, i_wr_data_exp, interface_1_exp, interface_2_exp, o_full_exp, o_empty_exp, o_rd_data_exp]
    results = [i_wr_en_res, i_wr_q_en_res, i_rd_en_res, i_rd_q_en_res, i_wr_data_res, interface_1_res, interface_2_res, o_full_res, o_empty_res, o_rd_data_res]
    tags = ["i_wr_en","i_wr_q_en","i_rd_en","i_rd_q_en","i_wr_data", "interface_1", "interface_2", "o_full", "o_empty", "o_rd_data"]
    for tag, exp, res in zip(tags, expectations, results):
        msg = f"init_assert: For {tag} expectation = {exp} and result = {res}"
        assert exp == res, msg

@dataclass
class ChannelState:
    i_wr_en:   int = -99
    i_rd_en:   int = -99
    i_wr_data: int = -99
    rdy:       int = -99
    ack:       int = -99
    data:      int = -99
    o_rd_data: int = -99

@dataclass
class FifoState:
    i_wr_en:          int = -99
    i_wr_q_en:        int = -99
    i_rd_q_en:        int = -99
    i_rd_en:          int = -99
    i_wr_data:        int = -99
    interface_data_1: int = -99
    interface_data_2: int = -99
    o_empty:          int = -99
    o_full:           int = -99
    o_rd_data:        int = -99
    in_chan:  ChannelState = field(default_factory=ChannelState)
    out_chan: ChannelState = field(default_factory=ChannelState)

def get_fifo_state(dut)->FifoState:
    in_chan = ChannelState(
        i_wr_en = convert_to_int(dut.async_interface_1.i_wr_en),
        i_rd_en = convert_to_int(dut.async_interface_1.i_rd_en),
        i_wr_data = convert_to_int(dut.async_interface_1.i_wr_data),
        rdy = convert_to_int(dut.async_interface_1.rdy),
        ack = convert_to_int(dut.async_interface_1.ack),
        data = convert_to_int(dut.async_interface_1.data),
        o_rd_data = convert_to_int(dut.async_interface_1.o_rd_data),
    )
    out_chan = ChannelState(
        i_wr_en = convert_to_int(dut.async_interface_2.i_wr_en),
        i_rd_en = convert_to_int(dut.async_interface_2.i_rd_en),
        i_wr_data = convert_to_int(dut.async_interface_2.i_wr_data),
        rdy = convert_to_int(dut.async_interface_2.rdy),
        ack = convert_to_int(dut.async_interface_2.ack),
        data = convert_to_int(dut.async_interface_2.data),
        o_rd_data = convert_to_int(dut.async_interface_2.o_rd_data),
    )

    i_wr_en = convert_to_int(dut.i_wr_en)
    i_wr_q_en = convert_to_int(dut.i_wr_q_en)
    i_rd_en = convert_to_int(dut.i_rd_en)
    i_rd_q_en = convert_to_int(dut.i_rd_q_en)
    i_wr_data = convert_to_int(dut.i_wr_data)
    interface_data_1 = convert_to_int(dut.interface_data_1)
    interface_data_2 = convert_to_int(dut.interface_data_2)
    o_empty = convert_to_int(dut.o_empty)
    o_full = convert_to_int(dut.o_full)
    o_rd_data = convert_to_int(dut.o_rd_data)

    fifo_state = FifoState(
        i_wr_en = i_wr_en,
        i_wr_q_en= i_wr_q_en,
        i_rd_q_en = i_rd_q_en,
        i_rd_en = i_rd_en,
        i_wr_data = i_wr_data,
        interface_data_1 = interface_data_1,
        interface_data_2 = interface_data_2,
        o_empty = o_empty,
        o_full = o_full,
        o_rd_data = o_rd_data,
        in_chan = in_chan,
        out_chan= out_chan
    )
    return fifo_state

def print_channel_state(dut):
    s = get_fifo_state(dut)
    dut_str = "-------------------------------------------DUT.Channel_In----------------------------------\n"
    dut_str += f"i_wr_en   = {s.in_chan.i_wr_en}| rdy = {s.in_chan.rdy} | \n"
    dut_str += f"i_rd_en   = {s.in_chan.i_rd_en}| ack = {s.in_chan.ack} | o_rd_data = {s.in_chan.o_rd_data} \n"
    dut_str += f"i_wr_data = {s.in_chan.i_wr_data}| data = {s.in_chan.data}| \n"

    dut_str += "-------------------------------------------DUT.Channel_Out----------------------------------\n"
    dut_str += f"i_wr_en   = {s.out_chan.i_wr_en}| rdy = {s.out_chan.rdy} | \n"
    dut_str += f"i_rd_en   = {s.out_chan.i_rd_en}| ack = {s.out_chan.ack} | o_rd_data = {s.out_chan.o_rd_data} \n"
    dut_str += f"i_wr_data = {s.out_chan.i_wr_data}| data = {s.out_chan.data}| \n"

    dut._log.info(dut_str)
    



def print_fifo_state(dut,context:dict)->None:
    model_str = "-----------------------------------------model--------------------------------\n"

    model_str += f"i_wr_en   = {context["i_wr_en"]}|                                          |\n"
    model_str += f"i_wr_q_en = {context["i_wr_q_en"]}|                                          |o_full = {context["o_full"]}\n"
    model_str += f"i_rd_en   = {context["i_rd_en"]}|interface_1 = {context["interface_1"]}, q = {context["q"]}, interface_2 = {context["interface_2"]}  |o_empty = {context["o_empty"]}\n"
    model_str += f"i_rd_q_en = {context["i_rd_q_en"]}|                                          |o_data = {context["o_data"]}\n"
    model_str += f"i_data    = {context["i_data"]}|                                          |\n"

    s = get_fifo_state(dut)
    dut_str = "-------------------------------------------dut----------------------------------\n"
    dut_str += f"i_wr_en   = {s.i_wr_en}|                                          |\n"
    dut_str += f"i_wr_q_en = {s.i_wr_q_en}|                                          |o_full = {s.o_full}\n"
    dut_str += f"i_rd_en   = {s.i_rd_en}|interface_1 = {s.interface_data_1}, q = {"bla"}, interface_2 = {s.interface_data_2} |o_empty = {s.o_empty}\n"
    dut_str += f"i_rd_q_en = {s.i_rd_q_en}|                                          |o_data = {s.o_rd_data}\n"
    dut_str += f"i_data    = {s.i_wr_data}|                                          |\n"

    dut._log.info(
        model_str
    )
    dut._log.info(
        dut_str
   )

def get_action_name(context:dict)->str:
    return context["_action"]["name"]

def convert_to_int(val:...)->int:
    try:
        return int(val.value)
    except:
        return -99
