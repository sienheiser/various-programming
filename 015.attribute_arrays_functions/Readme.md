# Problem
This problem is to understand how to test a function that has a positive input using 
vhdl and cocotb

## Package
In a package define the a type that has three literals Hello, Bye and Unknown. 
Define the sting attribute of these literals. Then define an array that holds the
newly defined literals as values. Finally define a function that takes in a postive *x*
integer and returns an array of size x that holds the newly defined literatls. An example is
f(4) returns (Bye,Bye,Bye,Bye)
## Entity
Define an entity that has a generic value that is of type positive; has two ports
an input port for a clock signal and an output port that outputs an array that holds
values of the newly defined literals of size of the generic value. 

The entity must use the function defined in the package.

## testbench.vhdl
Define a testbench that takes the defined entity and check whether the output array has
the expected values from the function. 

## testbench.py
To do the same test using cocotb you need to define a wrapper that outputs the first two
values of the array. Then cocotb be can be used to check these two values.
