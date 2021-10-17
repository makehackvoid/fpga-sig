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
<figcaption>Fig 1 - Module Template</figcaption>
~~~

This matches the '139 datasheet exactly.

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
their tools, i.e. switch level is part of the language but not all
tools support it.

## Structural Level

At the structural level implementation works much like creating a digital
circuit in the lab. You take a bunch of components and wire them together.

Verilog has built-in support for the basic logic gates such NOT and NAND.
In the lab you take a NAND chip and mount it on the breadboard. In Verilog
you *instantiate* a primitive NAND gate. In the lab you physically wire gates
together. In Verilog you connect components using *nets*.

### Primitive Instantiation

Basic gates are known as primitives. They are built into Verilog.

~~~verilog
// General form
<primitive> <instance name> (<net1>, <net2>...);

// Examples
not  U1 (g, g_n);
nand U2 (y_n, a, b);
~~~

With the general form you first select the gate type and name. Supported
gate types are not, and, nand, or, nor, xor and xnor. Instance names are
for identification/documentation purposes. They need to be unique within
the module. Instance names are handy when examining synthesis output as 
they allow matching between the tool output and the original source.

The net list follows in parentheses. The gate output **must** be
specified first. Everything after that is regarded as a gate input.
There are no practical limits on the number of inputs, the tool will scale
accordingly.

### Nets

In Verilog nets are an abstract way of describing connections. If you're
familiar with object oriented languages I'd describe a net as an
abstract data type.

Most of the time you're going to be working with *wires* and *registers*.
When working at the structural level the net of choice is the *wire*.

Looking at the module definition given above you'll find no mention of
either wire or reg. That's because the default net type is wire.

Nets a, b, g_n and y_n are of *wire* type.

### Structural Implementation

Following the datasheet schematic exactly we can divide the gates into
three columns and then work top to bottom. Column 1 has three inverters,
column 2 has two inverters and column 3 has four nand gates.

We will also need to declare some additional nets.

~~~verilog
// Intermediate nets
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

Take some time to compare the code above to the schematic.

## Testing

Testing for the decoder involves creating a Verilog testbench and then
running it in a behavioural simulation. As a general rule you base the
testbench name off the module you are testing. For example, the
testbench for decoder2of4 is called decoder2of4_tb.

You need to create nets for input and output. Inputs need to be of
*reg* type because they are assigned values inside an initial block.
Output nets can be of *wire* type.

~~~verilog
module decoder2of4_tb;

    // Inputs
    reg g_n, a, b;

    // Outputs
    wire [3:0] y_n;

    // Instantiate module under test
    decoder2of4 u1 ( .g_n(g_n), .a(a), .b(b), .y_n(y_n) );

    initial begin
        // Device disabled      
        g_n = 1;
        b = 0; a = 0; #10;
        b = 0; a = 1; #10;
        b = 1; a = 0; #10;
        b = 1; a = 1; #10;

        // Device enabled      
        g_n = 0;
        b = 0; a = 0; #10;
        b = 0; a = 1; #10;
        b = 1; a = 0; #10;
        b = 1; a = 1; #10;
    end

endmodule
~~~

The test then instantiates the module under test. Instantiation syntax
is flexible and allows input/output values to be supplied either by
position or by name. When we instantiated the primitive gates the
positional form was used, i.e. output first, then inputs. With the
testbench we are using name matching format. For example, ".a(a)" means
connect the decoder2of4 input 'a' (.a) to the 'a' net.

The rest of the initial block runs through all posiible input
combinations of g_n, a and b.

Test output can be viewed using the graph output by the behavioural
simulation.

## Dataflow Level

Dataflow is the level of abstraction over structural/gate. It relies on
the use of *assign* statements along with logic equations. Verilog uses
the term 'continuous assignment' to refer to assign statements. They are
normally used to model combinational logic.

Logic equations use expression syntax similar to the C programming language.

~~~verilog
// General form
assign <net> = <expression> ;

// Examples
assign x = ! b;
assign y = a & b;
~~~

Synthesis of the first example will create an inverter, like C, ! is read
as 'not'. Synthesis of the second example results in an AND gate being
created.

### Dataflow Implementation

Implementation of the SN74139 decoder using the dataflow level of abstraction
looks like this:

~~~verilog
assign y_n[0] = !g_n & !b & !a;
assign y_n[1] = !g_n & !b & a;
assign y_n[2] = !g_n & b & !a;
assign y_n[3] = !g_n & b & a;
~~~

Basically a bunch of logic equations for each output. Using the '!' results
in net inversion, i.e. with a single character in dataflow we can acheive
something that required an entire line (gate) when using the structural
abstraction level.

Compare the dataflow implementation with the structural/gate level
implementation. Is it shorter? Is it clearer? Which of these would be
easier to maintain?

## Behavioural Level

Moving up another level we encounter the behavioural abstraction layer.
This is probably the most difficult layer to understand for two reasons:

1. Not everything expressed at this layer can be turned into hardware,
i.e. not all behavioural code is synthesisable
1. It uses procedural constructs such as if/then/else/case and loops.

The term Register Transfer Level (RTL) is often used to describe the
subset of behavioural level code that can actually be synthesised.

Behavioural level code can be used to specify combinational,
sequential and test bench logic.

### Procedural Blocks

Verilog uses the initial and always block contructs to wrap 
### Wire v Reg

## Behind the scenes
