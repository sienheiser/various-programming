# Problem
## Create a package
In a package 
01. Create a new attribute string type called enum_enc. 
02. Create a new enumeration type enc_t that has literals `Hello`, `Bye` and `Unknown`. 
03. Link the attribute type and enumeration type by stating an attribute specification between them.
04. Create a new array type called enc_array_t that holds enc_t types.

## Entity
Create an entity that has input ports 
clk : in std_logic,
inpa : in enc_t,
inpb : in enc_t,

and has output port
outp : out enc_array_t

The entity should take the two inputs and assign it to two positions in outp.




