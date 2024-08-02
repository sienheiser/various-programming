# Problem
1) In this problem we create a package pkg.vhdl that has an attribute of string type.
2) Then we will create entity.vhdl that will accept a three bit in put and encode it 
using the attribute
3) We will create a test bench in vhdl and pyton the check if it works as designed.

## Interesting behaviour
Notice in the testbench.vhdl file we can use the encoded text i.e. S_OK,S_BI etc.
In the testbench.py this is not done. We instead use their index in 8-bit binary.
So S_OK is a index 00000000, S_BI at 00000001, S_RBI at 00000010 and S_EBI at
00000011.
