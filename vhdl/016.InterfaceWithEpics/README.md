# Problem
This directory is dedicated gaining understanding on how one can connect epics with a vhdl hardware

## Hardware design

### Entity
The entity will have three input ports and one output port. 
  1. clk : in std_logic;
  2. rst : in std_logic;
  3. inp : in char;
  4. outp: out std_logic;
We will need to design a new type called char that contains four characters 'a','b','c','d'. 

### Behaviour
The behaviour the hardware will be as follows if inp = 'a' then outp = 1 else outp = 0.

## Questions to answer
The idea is to interface EPICS to this hardware. Make some IOCs that will read the output.

  1. What does it mean for a register to be read only. 
  2. How do we give an address to a register.
  3. Using EPICS how do we change the value of the inp.
  4. Using EPICS how do we read the value of the outp.


