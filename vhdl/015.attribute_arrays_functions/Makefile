SIM ?= ghdl

TOPLEVEL_LANG ?= vhdl

VHDL_SOURCES += ent.vhdl
VHDL_SOURCES += pkg.vhdl
VHDL_SOURCES += wrapper.vhdl


TOPLEVEL = wrapper

MODULE = testbench

include $(shell cocotb-config --makefiles)/Makefile.sim
