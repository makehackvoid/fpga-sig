`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Make Hack Void
// Engineer:      Stephen Davies
//
// Create Date:   31/10/2021
// Project Name:  tutorials
// Target Device: Any
// Description:   Trivial logic level demonstration.
// 
////////////////////////////////////////////////////////////////////////////////

module example01_tb;

    // Inputs
    reg a, b;

	 // Outputs
    wire a_and_b, a_or_b;

	 // Logic
    and u1 ( a_and_b, a, b );
	 or  u2 ( a_or_b,  a, b );

	 // Simulation
    initial begin
        #100;                  // Initially a,b have unknown value
        a = 0; #100;           // a has known value
        b = 0; #100;           // b has known value
        b = 0; a = 1; #100;
        b = 1; a = 0; #100;
        b = 1; a = 1; #100;
        $stop();
    end

endmodule
