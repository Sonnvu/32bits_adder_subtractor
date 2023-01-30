# 32bits_adder_subtractor

This project is a 32-bit adder/subtractor built in Vivado 2018.3 using mainly VHDL and a little bit of C. 
The repository contain 4 files:
- fulladdsub.vhd
- addsub_32bit.vhd
- lab_1_tb.vhd
- addsub_32bit.c
<br>
The first file is a full adder, which we would used as a component to build the 32-bit adder/subtractor in the second file. Once the 32 bit adder/subtractor 
is built, we use the lab_1_tb.vhd to test and run the behavioral simulation to check if the calculation is performed correctly. After successfully generating 
the bitstream, we move on to SDK and test the hardware by using the test bench file addsub_32bits.c
