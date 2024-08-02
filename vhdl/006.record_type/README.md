# Problem description
Create a record type in file pkg.vhdl, you can call it typ. This 
record must have two signals where the first signal is a 7-bit
signal and the second signal is a 1-bit signal.

Furthermore in the pkg.vhdl file, create a procedure that takes
an 8-bit input and outputs record typ. The procedure must map
the first 7-bits of the input the signal1 and the last bit of 
the input to signal2.

Then create an entity that brings time into the picture so that
we can test with mupltiple inputs

Create a testbench in vhdl and whether the output typ changes correctly
when you change the input.

Create the same testbench using cocotb in python.
