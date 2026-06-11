SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl

ifeq ($(TOPLEVEL),fifo)
    VHDL_SOURCES = fifo.vhdl
else
    VHDL_SOURCES = channel.vhdl
endif

COCOTB_TEST_MODULES = $(MODULE)

SIM_ARGS += --vcd=wave.vcd

include $(shell cocotb-config --makefiles)/Makefile.sim