# Lab 08 - Register File

Created: 31 July 2018

Updated: 31 July 2018

All CPU's have a register file, essentially a small number of memory locations
that are internal to the processor. They hold values frequently used by the
current code section. In other words, the CPU caches it most frequently accessed
values in the register file.

## Register File

The AVR register file operates as a dual port 32x8 memory cell. Both ports can
perform parallel reads asynchronously. One port, port1, can be used to
'write back' synchronously. This is controlled by the write enable (we) signal.

This exercise gets you to walkthough the testbench to see how parallel read/write
operations work.

1. Close the **playtime** project
1. Open the **avr_core** project
1. Locate the rtl/register_file.v file
1. Add it to the Vivado project as a design source
1. Mark it as the top module (Mark as Top)
1. Locate the testbench/register_file_tb.v file
1. Add it to the Vivado project as a simulation source
1. Mark it as the top module for simulation (Mark as Top)
1. Run behavioral simulation
1. Walkthrough the testbench for test sequence #1, matching the test code with
   the simulated waveform over the interval 20-180ns
1. Walkthrough the testbench for test sequence #2, matching the test code with
   the simulated waveform over the interval 190-490ns
1. Why does *dout1* appear to 'glitch' every 100ns?

## Synthesis

1. Run synthesis, open the synthesised design when prompted
1. Open the schematic
1. In the Synthesis menu (LHS), run the utilization report (Report Utilization)
1. How many LUTs are used?
1. How many slice registers are used?
1. Is there anything special about the number of registers?

## Alternate Design (Optional)

FPGA synthesis can be a bit of an art form and it pays to know your device and
the tool set.

1. Locate the rtl/register_file2.v file
1. Add it to the Vivado project as a design source
1. Mark it as the top module (Mark as Top)
1. Edit register_file_tb.v
1. Modify the device instanciation for DUT to use the alternate version
1. Run behavioural simulation
1. Run synthesis, open the synthesised design when prompted
1. Open the schematic
1. In the Synthesis menu (LHS), run the utilization report (Report Utilization)
1. How many LUTs are used?
1. How many slice registers are used?
