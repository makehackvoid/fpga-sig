# Lab 06 - Flip Flops

Created: 22 July 2018

Updated: 30 July 2018

Flips flops (FF) are fundamental design elements in FPGAs. They allow the synthesis of
many common sequential circuits including registers, counters and state machines.

This lab encourages flip flop 'playtime'.

## Workshop 2 Updates

The project repository has changed since the last workshop. If you created a local
Git repository you will need to update it.

You can synchronise your local repository with GitHub by changing to the directory
and issuing:

    C:\Temp\fpga-sig>git pull
    ...

If you copied the project files from USB stick you will need to repeat the process.

Copy all the project files into your Vivado project. This is a repeat of Lab02.

## Basic Operations

1. Locate the testbench/lab06_tb.v file
1. Add it to the Vivado project as a simulation source
1. Mark it as the top module for simulation (Mark as Top)
1. Run behavioural simulation
1. Note the waveforms for the clk, d and q signals (match slide example)

## Divide by Two

A simple application of a single D flip flop is a divide by two circuit. This involves
feeding back the inverted flip flop output to its input.

1. Edit lab06_tb.v
1. Add a new variable 'div2' to hold the flip flop output state (wire or reg)?
1. Use the Language Templates tool (Verilog -&gt; Synthesis Constructs -&gt;
   Coding Examples -&gt; Flip Flops -&gt; D Flip Flop -&gt; Posedge -&gt;
   Simple Register) to cut and paste an example (starting point)
1. Replace *&lt;clock&gt;* with *clk*
1. Replace *&lt;reg&gt;* with *div2*
1. Replace *&lt;signal&gt;* with *!div2*
1. Run behavioural simulation
1. Verify that signal *div2* changes state at every positive edge of *clk*
