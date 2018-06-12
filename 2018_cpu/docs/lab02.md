# Lab 02 - Vivado Project Creation

Created: 31 May 2018

Updated: 31 May 2018

The aim of this exercise is to use the Vivado IDE to create a project for
the AVR CPU.

Setting up Vivado projects uses a simple, wizard based flow. Take your time and
work carefully. You can always go backwards if something isn't right.

## Project Creation

1. Create a new directory to store your Vivado projects e.g. C:\Users\sjdavies\Xilinx
1. Launch Vivado -> Vivado Window opens
1. Select Quick Start > Create Project -> New Project dialog opens
1. Click Next button -> Project Name wizard
1. Enter *Project name:* **avr_core**,
1. Enter *Project location:* **&lt;your project home directory&gt;** e.g. C:/Users/sjdavies/Xilinx
1. Leave *Create project subdirectory* checked (default)
1. Click Next button -> Project Type wizard
1. Select **RTL Project** (default)
1. Check *Do not specifiy sources at this time*
1. Click Next button -> Default Part wizard
1. In the *Search* field enter **xc7s25c\***
1. Select part **xc7s25csga225-1**
1. Click Next button -> New Project Summary wizard
1. Click Finish button -> Vivado Project Manager opens

## Copy Project Files

Locate the lab files. If you completed lab01a then they will be in your local
repository. If you copied them from the flash drive then look where
you copied them to. The base path is **&lt;base dir&gt;**/2018_cpu/code.

Copy the following directories into your project root:

* include
* rtl
* testbench

e.g. **&lt;base dir&gt;**/2018_cpu/code/include to C:\Users\sjdavies\Xilinx\avr_code\include.

## Add Sources to Project

Once the files have been copied we need to load them into the project. Files can
be selected individually or by loading entire directories. Loading an entire directory
will save time but for this lab it is prefered you load the three required files individually. Less distractions that way.

### Adding Design Sources

1. In the Project Manager window locate the Sources panel
1. Move your mouse cursor over the fourth toolbar button, the one that looks like a plus sign
1. Click the Add Sources button -> Add Sources dialog opens
1. Select **Add or create sources**
1. Click Next button -> Add or Create Design Sources wizard
1. Click the Add Files button -> Add Source Files dialog opens
1. Navigate into the &lt;project&gt;/include directory and select the defines.vh file
1. Click the Ok button
1. Repeat the previous three steps, this time select the file rtl/logic.v
1. When you have added the defines.vh and logic.v files you can click the Finish button

The Sources panel should now show two files listed under Design Sources. One is
categorised as a non-module file, defines.vh. This is a Verilog header file and works
the same way that .h files do in a C language project.

As a final step we need to mark the header file as a global include file.

1. In the Sources panel select the defines.vh file -> the Source File Properties contains details for the selected file
1. In the Source File Properties panel locate the tab buttons, they run along the bottom
1. Click the Properties button -> file properties update
1. Check the box marked IS_GLOBAL_INCLUDE

The Source panel will now have a folder named Global Include under Design Sources.
The icon next to the defines.vh file will look something like a basketball.

### Adding Simulation Sources

To complete the lab we will import a Verilog testbench. The process is much the same as
the previous with one exception, we add or create simulation sources.

1. Click the Add Sources button -> Add Sources dialog opens
1. Select **Add or create simulation sources**
1. Click Next button -> Add or Create Design Sources wizard
1. Click the Add Files button -> Add Source Files dialog opens
1. Navigate into the &lt;project&gt;/testbench directory and select the logic_tb.v file
1. Click the Ok button
1. Click the finish button

## Run Simulation

To verify the setup:

1. Locate the Flow Navigator (LHS)
1. Locate the item *Run Simulation*
1. Click Run Simulation -> a context menu opens
1. Click Run Behaviorial Simulation -> Simulation window opens, graph visible

## Summary

Congratulations! getting this far means you have a working project.

You may want to use any remaining time to look through the project source files
and check the simulation results. Output from the simulation run can be found at the
bottom of the main window, cunningly disguised as *Tcl Window*. You may need to
resize that part of the screen to see it clearly.
