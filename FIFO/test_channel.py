import json
import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def test_channel(dut):
    filename = "trace-1779100068.json"
    with open(filename,"r") as file:
        traces = json.load(file)

    contexts = []
    for i, trace in enumerate(traces):
        for j ,context in enumerate(trace):
            contexts.append((get_action_name(context),context,j,i))

    clock = Clock(dut.i_clk,1,'ns')
    cocotb.start_soon(clock.start())

     # DUT state persists across all actions below
    for action_name, context, ctx_id, trace_id in contexts:

        dut._log.info(
            f"Running trace={trace_id} ctx={ctx_id} action={action_name}"
        )


        if action_name == "Init":
            await init_channel_state(dut, context)
        else:
            await next_channel_state(dut, context)

        dut._log.info(
            f'''
            i_wr_en = {dut.i_wr_en.value}   | rdy = {dut.rdy.value}    |
            i_rd_en = {dut.i_rd_en.value}   | ack = {dut.ack.value}    | o_rd_data = {int((dut.o_rd_data.value))}
            i_wr_data = {int((dut.i_wr_data.value))} | data = {int((dut.data.value))}   |
'''
        )

        dut._log.info(
            f'''
            i_wr_en = {context["i_wr_en"]}   | rdy = {context["chan"]["rdy"]}    |
            i_rd_en = {context["i_rd_en"]}   | ack = {context["chan"]["ack"]}    | o_rd_data = {context["o_rd_data"]}
            i_wr_data = {context["i_wr_data"]} | data = {context["chan"]["val"]}   |
'''
        )

        assert_channel_state(dut, context)

async def init_channel_state(dut, context:dict)->None:
    '''
        Initializing the DUT
    '''
    dut.i_wr_en.value = 1

    dut.i_rd_en.value = context["i_rd_en"]

    dut.i_wr_data.value = context["i_wr_data"]

    dut.i_rst.value = 0
    await Timer(2, 'ns')

    dut.i_wr_en.value = 0
    await Timer(2, 'ns')

    dut.i_rd_en.value = 1
    await Timer(2, 'ns')

    dut.i_rd_en.value = 0
    await Timer(2, 'ns')

    dut.i_wr_en.value = 1
    await Timer(2, 'ns')

    dut.i_wr_en.value = 0
    await Timer(2, 'ns')

    dut.i_rd_en.value = 1
    await Timer(2, 'ns')

    dut.i_rd_en.value = 0
    await Timer(2, 'ns')

async def next_channel_state(dut, context:dict)->None:
    dut.i_wr_en.value = int(context["i_wr_en"])

    dut.i_rd_en.value = int(context["i_rd_en"])

    dut.i_wr_data.value = int(context["i_wr_data"])
    await Timer(2, 'ns')

def assert_channel_state(dut, context:dict)->None:
    i_wr_en_exp = context["i_wr_en"]
    i_wr_en_res = dut.i_wr_en.value

    i_rd_en_exp = context["i_rd_en"]
    i_rd_en_res = dut.i_rd_en.value

    i_wr_data_exp = context["i_wr_data"]
    i_wr_data_res = dut.i_wr_data.value

    o_rd_data_exp = context["o_rd_data"]
    o_rd_data_res = dut.o_rd_data.value

    rdy_exp = context["chan"]["rdy"]
    rdy_res = dut.rdy.value

    ack_exp = context["chan"]["ack"]
    ack_res = dut.ack.value

    data_exp = context["chan"]["val"]
    data_res = dut.data.value

    expectations = [i_wr_en_exp, i_rd_en_exp, i_wr_data_exp, o_rd_data_exp,rdy_exp,ack_exp,data_exp]
    results = [i_wr_en_res, i_rd_en_res, i_wr_data_res, o_rd_data_res,rdy_res,ack_res,data_res]
    tags = ["i_wr_en", "i_rd_en", "i_wr_data", "o_rd_data", "rdy", "ack", "data"]

    for tag, exp, res in zip(tags, expectations, results):
        msg = f"init_assert: For {tag} expectation = {exp} and result = {res}"
        assert exp == res, msg




def get_action_name(context:dict)->str:
    return context["_action"]["name"]