# Lab 10 - Control ROM

Created: 2 August 2018

Updated: 2 August 2018

This lab focuses on instruction decoding and the final control elements for
the AVR core. At the end of this lab you will finally have a running CPU that
can execute all of three instructions.

Like many of the previous labs some of the code has been written for you.
Work slowy and carefully to instantiate the various components and wire them
together.

## Control ROM

1. Locate the rtl/control_rom.v file
1. Add it to the Vivado project as a design source
1. Edit avr_core.v
1. Locate the modules port declaration (at top of module)
1. Add a single bit output port *we* after *rf2*
1. Locate the section for U3 (comment)
1. Instantiate a control_rom module and name it U3
1. Wire the *opcode* port to *opcode*
1. Wire the *we_ctrl* port to *we*
1. Locate the register_file instantiation (U4)
1. Rewire the *we* port to *we*, i.e. replace hardcoded signal with control ROM output
1. Edit avr_core_tb.v
1. Add a single bit variable *we* after *rf2*
1. Locate the avr_core instantiation (DUT)
1. Wire the *we* port to *we*
1. Run behavioral simulation
1. Verify the following:

pc | 0 | 1 | 2 | 4
--- | --- | --- | --- | ---
instruction | ea05 | e01f | 2301 | 0000
opcode | 3a | 38 | 08 | 00
we | 1 | 1 | 1 | 0

Once this checks out we can safely say that the nop instruction is working correctly.

## Load Immediate - Register (Rd)

With the Load Immediate (ldi) instruction we need to make three datapath changes. The
first change involves the destination register Rd. Immediate instructions only have 4
bits available to store Rd so the high order bit (4) is assumed to be 1.

The simplest way to implement this is to use a multiplexer based on the conditional 
operator (?:). Note - rf1 is set using continuous assignment.

1. Edit avr_core.v
1. Locate the variables section (under module ports)
1. Add a single bit variable *immediate* after *rr*
1. Locate the control_rom instantiation (U3)
1. Wire the *rdmux_ctrl* port to *immediate*
1. Locate "assign rf1 = rd"
1. Alter this to read "assign rf1 = immediate ? { 1'b1, instruction[7:4] } : rd;"
1. Run behavioral simulation
1. Verify the following:

pc | 0 | 1 | 2 | 4
--- | --- | --- | --- | ---
instruction | ea05 | e01f | 2301 | 0000
opcode | 3a | 38 | 08 | 00
rf1 | 10 | 11 | 10 | 00
rf2 | 15* | 0f* | 11 | 00
\* - Don't care, load immediate only specifies a single register

## Load Immediate - Constant (K)

With the Load Immediate (ldi) instruction we need to make three datapath changes. The
second change involves the constant (K) value. This field occupies two sections in
the instruction word. We need to first concatenate it (same way opcode gets assigned),
then we need to add a new datapath and multiplexer to get it routed into ALU port b.

1. Edit avr_core.v
1. Locate the variables section (under module ports)
1. Add an 8 bit vector variable *k* after *immediate*
1. Add an 8 bit vector variable *rf2out* after *k*
1. Add single bit variable *useK* after *rf2out*
1. Locate "assign rr = ..."
1. Add another line "assign k = { instruction[11:8], instruction[3:0] };"
1. Locate the control_rom instantiation (U3)
1. Wire the *bmux_ctrl* port to *useK*
1. Locate the register_file instantiation (U4)
1. Rewire the *dout2* port to *rf2out*
1. After U4 add the line "assign b = useK ? k : rf2out;"
1. Run behavioral simulation
1. Verify the following:

pc | 0 | 1 | 2 | 4
--- | --- | --- | --- | ---
instruction | ea05 | e01f | 2301 | 0000
opcode | 3a | 38 | 08 | 00
rf1 | 10 | 11 | 10 | 00
rf2 | 15 | 0f | 11 | 00
a | 00 | 00 | 00 | 00
b | a5 | 0f | 00 | 00
sum | 00 | 00 | 00 | 00

At this point datapaths are correctly routing into the ALU. The reason for sum being
00 in all cases is simple. It is currently hardcoded to perform an AND and the *a*
input in all of the above cases has been 00. Time to fix that.

## Load Immediate - ALU Control

The third datapath change is to wire the control_rom ALU function code output to the
ALU. The control_rom outputs `ALUFN_PASSB for the ldi instruction. This passes the
value of the *b* input through unchanged.

1. Edit avr_core.v
1. Locate the modules port declaration (at top of module)
1. Add a 2 bit vector output port *aluop* after *b*
1. Locate the control_rom instantiation (U3)
1. Wire the *alu_ctrl* port to *aluop*
1. Locate the logic (ALU) instantiation (U5)
1. Wire the *fn* port to *aluop*
1. Edit avr_core_tb.v
1. Add a 2 bit vector variable *aluop* after *b*
1. Locate the avr_core instantiation (DUT)
1. Wire the *aluop* port to *aluop*

## Smoke Test

1. Run behavioral simulation
1. Verify the following:

pc | 0 | 1 | 2 | 4
--- | --- | --- | --- | ---
instruction | ea05 | e01f | 2301 | 0000
opcode | 3a | 38 | 08 | 00
rf1 | 10 | 11 | 10 | 00
rf2 | 15 | 0f | 11 | 00
we | 1 | 1 | 1 | 0
aluop | 3 | 3 | 0 | 3
a | 00 | 00 | a5 | 00
b | a5 | 0f | 0f | 00
sum | a5 | 0f | 05 | 00

Wiring the ALU function code has a side effect. The AND instruction is also working,
a5 AND 0f is 05.

Congratulations! You now have a working AVR CPU core.
