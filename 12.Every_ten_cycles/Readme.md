# Problem
In this problem we learn how to write a synthesizable delay for FPGAs in vhdl.

## Entity
Define an entity ent that has two ports. An input port that takes a clock and 
an output port that returns a std_logic type.

### Architecture
The entity must output a '1' on every 10th rising edge otherwise it must output
'0'.
