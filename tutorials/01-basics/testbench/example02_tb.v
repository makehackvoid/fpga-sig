`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Make Hack Void
// Engineer:      Stephen Davies
//
// Create Date:   31/10/2021
// Project Name:  tutorials
// Target Device: Any
// Description:   A trivial demonstration of 3 state logic levels.
// 
////////////////////////////////////////////////////////////////////////////////

module example02_tb;

    reg i, t;                  // i=input, t=tri-state control

    wire o, y;

    assign o = t ? i : 1'bz;

    not u1 ( y, o );           // why? to show how a gate handles a Z input value

    initial begin
        i = 0; t = 0; #100;    // output o in high-impedance state (z)
        t = 1; #100;           // enable output o
        i = 1; #100;
        $stop();
    end

endmodule
