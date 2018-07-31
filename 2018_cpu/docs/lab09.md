# Lab 09 - AVR Core Assembly

Created: 1 August 2018

Updated: 1 August 2018

Up to this point we have been concentrating on building the small components
required by the processor. Now it is time to start putting the pieces together.

Like many of the previous labs some of the code has been written for you.
Work slowy and carefully to instantiate the various components and wire them
together.

## AVR Core

1. Locate the rtl/avr_core.v file
1. Add it to the Vivado project as a design source
1. Mark it as the top module (Mark as Top)
1. Locate the testbench/avr_core_tb.v file
1. Add it to the Vivado project as a simulation source
1. Mark it as the top module for simulation (Mark as Top)

Read through the avr_core module. You will find it declares all of the required
variables and wires.

## Program Counter

The program counter has the *clk* and *reset* signals as inputs. It outputs
a 4 bit count value *pc*.

1. Edit avr_core.v
1. Locate the section for U1
1. Instantiate a pc module and name it U1
1. Wire the *clk* port to *clk* - e.g. .clk(clk)
1. Wire the *reset* port to *reset*
1. Wire the *pc* port to *pc*

## Program ROM

The program ROM outputs the instruction at the PC's current location.

1. Locate the section for U2
1. Instantiate a prog1 module and name it U2
1. Wire the *a* (address) port to *pc*
1. Wire the *dout* port to *instruction*

At this point in the file there are several assign statements that break up the
*instruction* into smaller fields. These will be explained in the next lecture.

## Register File

Register file control can get complicated. In the interest of getting something
working the inputs have been simplified a little (for now).

1. Locate the section for U4 (ignore U3 for now)
1. Instantiate a register_file module and name it U4
1. Wire the *clk* port to *clk*
1. Wire the *reset* port to *reset*
1. Wire the *we* port to a literal 1'b0, i.e. hardcode it for now
1. Wire the *add1* port to *rf1*
1. Wire the *add2* port to *rf2*
1. Wire the *din1* port to *sum*
1. Wire the *dout1* port to *a*
1. Wire the *dout2* port to *b*

If you have been paying attention you will have spotted that the ALU output is
fed back into the register file. More on this in the next lecture.

## ALU

1. Locate the section for U5
1. Instantiate a logic module and name it U5
1. Wire the *a* port to *a*
1. Wire the *b* port to *b*
1. Wire the *fn* port to `ALUFN_AND, i.e. hardcode it for now
1. Wire the *sum* port to *sum*

## Smoke Test

1. Run behavioral simulation
1. Verify the following:

pc | 0 | 1 | 2 | 4
--- | --- | --- | --- | ---
instruction | ea05 | e01f | 2301 | 0000
opcode | 3a | 38 | 08 | 00
rf1 | 00 | 01 | 10 | 00
rf2 | 15 | 0f | 11 | 00
a | 00 | 00 | 00 | 00
b | 00 | 00 | 00 | 00
sum | 00 | 00 | 00 | 00
