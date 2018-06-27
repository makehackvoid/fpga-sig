# Lab 05 - Common Errors

Created: 27 June 2018

Updated: 27 June 2018

Certain types of errors are common to the new Verilog programmer. The aim of this
exercise is to make a few of those errors and see they way manifest.

## Reg vs Wire Mixups

One of the more confusing parts of Verilog is the wire vs reg requirements. It is
very easy to get this wrong and sometimes the error messages aren't as obvious as
you'd like.

1. Open the logic.v file
1. Modify the port definition for output signals s, z etc. so that it changes from a wire type to a reg type i.e. insert the 'reg' keyword
1. Run behavioural simulation
1. Locate the error message in the Tcl Console. Does the error mesage make sense to you?
1. Remove the 'reg' keyword from the s, z port i.e. undo previous change
1. Modify the port definition for output signal sum so that it changes from a reg type to a wire type i.e. remove the 'reg' keyword
1. Run behavioural simulation
1. Locate the error message in the Tcl Console.  Does the error mesage make sense to you?
1. Add the 'reg' keyword to the sum port i.e. undo previous change
1. Run behavioural simulation
1. Verify all tests pass

## Combinational Sensitivities

Sensitivity lists will cause problems with combinational circuits when you get them
wrong. Verilog 2001 makes this less likely due to the @* value but you will encounter
many examples of older style sensitivity lists in textbooks and internet search
results.

They aren't wrong, just an older style that was error prone. The language was updated
in 2001 to make this less likely to occur.

1. Open the logic.v file
1. Modify the always statement sensitivity list to read '@(fn or a or b)'
1. Run behavioural simulation
1. The module should pass all tests
1. Modify the always statement sensitivity list to read '@(fn, a)'
1. Run behavioural simulation
1. The module should fail test 6 but pass all others
1. Modify the always statement sensitivity list to read '@(fn)'
1. Run behavioural simulation
1. The module should fail multiple tests. What do the passing tests have in common?
1. Modify the always statement sensitivity list to read '@*'
1. Run behavioural simulation
1. Verify all tests pass
