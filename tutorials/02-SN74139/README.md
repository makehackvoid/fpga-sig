# Tutorial #2 - SN74139 2 to 4 Decoder
Created November 2019
Stephen Davies

## Aim

To introduce the Verilog abstraction layers, their associated styles
and become more familiar with synthesis output.

## Overview

The SN74139 2 of 4 decoder is a common TTL component used in digital
circuits to select between memories or peripheral chips. Google 
'sn74139 datasheet texas' to locate the Texas Instruments datasheet.

It has two select inputs, A and B, and an enable input G (active low).
There are four outputs Y0 through Y3. All outputs are active low.
The Function Table shows possible input/output combinations. When
G is high the decoder is disabled and all outputs go high. When G is
taken low, i.e. decoder enabled, one of the outputs will go low. A and
B values determine which output becomes active.

The second datasheet page shows the schematic, basically a bunch of
NAND gates and inverters, nothing complicated.

The chip itself contains two individual decoders. For the rest of this
tutorial we are going to focus on implementing a single decoder.

## Module Structure

At the top level we can describe the input/output signals for the decoder like
this:

~~~verilog
module decoder2of4(
    input        g_n,
    input        a,
    input        b,
    output [3:0] y_n
    );

    // implementation goes here

endmodule
~~~

This matches the datasheet exactly.

Note the use of a naming convention to indicate active low inputs and
outputs e.g. g_n and y_n.

## Verilog Abstraction Layers

Verilog targets a wide audience, it tries to be all things to all people.
One of the difficulties I found when starting out was that none of the
material I was reading discussed abstraction layers, it was just assumed
knowledge.

Verilog supports the following abstraction layers:

1. Switch Level (lowest)
1. Structural/Gate Level
1. Dataflow Level
1. Behavioural Level (RTL) (highest)

Each has their own coding style which we'll look at more closely below.

## Switch Level

At the lowest level the Verilog language allows for the modelling of circuits
at the transistor level. This level is primarily of interest to chip
designers. You could specify individual N and P channel transistors to
create your own inverter.

Vendors such as Xilinx do not support this level of abstraction in
their tools, i.e. switch level is part of the lanaguage but not all
tools support it.

## Structural Level

At the structural level implementation works much like creating a digital
circuit in the lab. You take a bunch of components and wire them together.

Verilog has built-in support for the basic logic gates such NOT and NAND.
In the lab you take a NAND chip and mount it on the breadboard. In Verilog
you *instantiate* a primitive NAND gate. In the lab you physically wire gates
together. In Verilog you connect components using *nets*.

### Primitive Instantiation

Basic gates are known as primitives. They are built-in to the lanaguage.

~~~verilog
// General form
<primitive> <name> (<net1>, <net2>...);

// Examples
not  U1 (g, g_n);
nand U2 (y_n, a, b);
~~~

With the general form you first select the gate type and name. Names are
for identification/documentation purposes. They need to be unique within
a module. The are handy when examining synthesis output as they allow
matching between the tool output and the original source.

The net list follows in parentheses. The gate output **must** be
specified first. Everything after that is regarded as a gate input.
There are no practical limits on the number of inputs, the tool will scale
accordingly.

###
### Structural Implementation

Following the datasheet schematic exactly we can divide the gates into
three columns and then work top to bottom. Column 1 has three inverters,
column 2 has two inverters and colun 3 has four NAND gates.  
~~~verilog
wire g, a_n, b_n, a_buf, b_buf;
	 
not u1 (g, g_n);    // Column 1
not u2 (a_n, a);
not u3 (b_n, b);

not u4 (a_buf, a_n); // Column 2
not u5 (b_buf, b_n);
	 
nand u6 (y_n[0], a_n, b_n, g); // Column 3
nand u7 (y_n[1], g, b_n, a_buf);
nand u8 (y_n[2], g, a_n, b_buf);
nand u9 (y_n[3], g, a_buf, b_buf);
~~~

## Testing

## Dataflow Implementation

## Register Transfer Language

## Behind the scenes