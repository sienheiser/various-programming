# Problem
## Create a package
The package should have 
1. A newly defined string attribute enum_enc.
2. A newly defined enumerated type enc_t.
3. A link between the enum_enc and enc_t.
4. A array type ent_array_t that holds values of type enc_t.
5. A function that converts a 2-bit std_logic_vector to a enc_t.
6. A function that converts an ent_t to a 2-bit std_logic_vector.
7. A function that converts an even numbered bit std_logic_vector to ent_array_t.
8. A function that converts an ent_arrat_t to an even numbered bit std_logic_vector.

## Create entities

### Entity 1
Entity 1 should have three ports. Two input ports
clk : in std_logic;
inp : in enc_array_t(1 downto 0)

and one output pot
outp : out std_logic_vector(3 downto 0)

It should take the input and convert it to an std_logic_vector and output that vector.

### Entity 2
Entity 2 should have three ports. Two input ports
clk : in std_logic;
inp : in std_logic_vector(3 downto 0)

and one output pot
outp : out enc_array_t(1 downto 0)

It should take the input and convert it to an enc_array_t and output that array.

## Test bench VHDL
### Entity 1
In this test bench assign the literal `Bye` to the two available positions in the 
array. Then test whether your output vector is "0101".

### Entity 2
IN this test bench set the inp to "0101" and check that both the position of the output
array contains literal `Bye`

## Test bench python
Do the same as in Test bench VHDL but use cocotb VHDL.
