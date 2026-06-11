# Introduction 
This project aims to specifiy an ideal FIFO then a specifiy a FIFO that is closer to an VHDL implementation. After that make a VHDL implementation and finally, test the Detailed FIFO model against the implementation.

Read the specification in the following order
1. FIFO.tla
2. FIFOImpl.tla

Then read fifo.vhdl (the implementation in VHDL).

# Generating traces from FIFOImpl
To generate traces of the model behaviour run the following command
```
java -jar /etc/tla/toolbox/tla2tools.jar -simulate "num=<num_of_initializations>" -depth <num_steps>   TraceFifo.tla
```
<num_of_initializations>: makes you control how many different initializations you can do. 
<num_steps>: How many steps each initialization should take at most.

Note: If you set number of steps to 10000 with three initializations it would take about 30 mins to generate the traces into a single file.

# Running cocotb testbench
After generating the traces from FIFOImpl.tla you will see a json file with name trace-.... Copy the name of this file, open test_fifo.py updated the filename variable with the name of the file.

To run the cocotb testbench use the following command
```
make MODULE=test_fifo TOPLEVEL=fifo
```

Make sure that you have a python virtual environment active. The environment must have cocotb, pytest installed.

