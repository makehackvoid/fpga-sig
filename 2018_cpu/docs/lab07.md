# Lab 07 - Flip Flop Control Signals

Created: 31 July 2018

Updated: 31 July 2018

Flips flops (FF) are fundamental design elements in FPGAs. They allow the synthesis of
many common sequential circuits including registers, counters and state machines.

This lab delves deeper into the key FF control signals reset and enable.

## Reset

The exercise gets you to implement two flip flops, one with synchronous reset, one
with asynchronous reset.

1. Locate the rtl/ff_07.v file
1. Add it to the Vivado project as a design source
1. Mark it as the top module (Mark as Top)
1. Locate the testbench/lab07_tb.v file
1. Add it to the Vivado project as a simulation source
1. Mark it as the top module for simulation (Mark as Top)
1. Edit ff_07.v
1. Implement the synchronous reset FF - Use the Language Templates tool
  (Verilog -&gt; Synthesis Constructs -&gt;
   Coding Examples -&gt; Flip Flops -&gt; D Flip Flop -&gt; Posedge -&gt;
   w/ Synchronous Active High Reset) to cut and paste an example (starting point)
1. Replace *&lt;clock&gt;* with *clk*
1. Replace *&lt;reset&gt;* with *reset*
1. Replace *&lt;reg&gt;* with *qs* (2 places)
1. Replace *&lt;signal&gt;* with *d*
1. Implement the asynchronous reset FF - start by cutting & pasting the synchronous
   FF code
1. Replace *qs* with *qa* (2 places)
1. Alter the sensitivity list to include ', posedge reset'
1. Edit lab07_tb.v
1. Create an instance of the ff_07 component (instantiate) and wire it to the test
   signals
1. Run behavioural simulation
1. Examine the resulting waveforms (0-75ns)
1. Can you explain the differences between the *qs* and *qa* signals?
1. Why does the last transition of *reset* have no effect on *qs*?
1. Run Synthesis, open the synthesised design when prompted
1. Open the schematic
1. What primitives have been used to implement the ff_07 component?
1. What are the *CE* inputs connected to?

## Clock Enable

All Xilinx 7 series flip flops have a clock enable pin (by design). This allows a
limited number of jitter free clocks to be distributed throughout the chip. When
different parts of the circuit need to be driven at fractions of one clock Xilinx
recommend the use of clock enable circuitry (XAPP790).

1. Edit ff_07.v
1. Add a *ce* input to the module
1. Modify the synchronous FF to include a *ce* input (else if)
1. Modify the asynchronous FF to include a *ce* input (else if)
1. Edit lab07_tb.v
1. Uncomment the *ce* (reg) variable at the top of the testbench
1. Uncomment the clock enable stimulus section at the bottom of the testbench
1. Add the *ce* singnal to the ff_07 instantiation
1. Run behavioural simulation
1. Examine the resulting waveforms (75-95ns)
1. Run Synthesis, open the synthesised design when prompted
1. Open the schematic
1. What changed?
