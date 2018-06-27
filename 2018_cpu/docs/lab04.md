# Lab 04 - Symbolic Values

Created: 27 June 2018

Updated: 27 June 2018

The aim of this exercise is to improve code readability by replacing literal
binary constants with human readable symbolic equivalents.

[Verilog HDL Quick Reference Guide](http://sutherland-hdl.com/pdfs/verilog_2001_ref_guide.pdf)

## Steps

1. Open the defines.vh file
1. In defines.vh, look at lines 53-57, these are the values you need
1. Open the logic.v file
1. Add a new line at the top (line 2) to include defines.vh
1. In the body of your logic.v rewrite the case statement labels to use symbolic value names (don't forget the backtick character)
1. Re-run behavioural simulation
1. Check that nothing has broken i.e. all tests continue to pass
