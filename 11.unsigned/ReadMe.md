# Problem
In this problem we are going to understand how to use unsigned type

## Entity
Create an entity with the following input ports
clk: in std_logic,
rst: in std_logic,
inpa: in std_logic_vector(2 downto 0),
inpb: in std_logic_vector(2 downto 0),

and the following output port
outp: out unsigned(2 downto 0)

## Architecture
In the architecture there is a signal us1 of type usigned(2 downto 0)
define a process that depends on the rst and clk. If rst = '0' then
inpa and inpb should be zero vector. Else if the clock goes to 1 then 
assing the sum of inpa and inpb to us1

## Testbench
Check that the summation is done correctly.

