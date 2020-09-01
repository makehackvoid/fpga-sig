`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:      Stephen Davies
//
// Create Date:   01 Sep 2020
// Target Device: Spartan 6
// Tool versions: ISE 14.7
// Description:   Verilog test fixture.
// 
////////////////////////////////////////////////////////////////////////////////

module dcm_50to3_tb;

    parameter PERIOD = 20;

	// Inputs
	reg clk;

	// Outputs
	wire clkout;

	// Instantiate the Unit Under Test (UUT)
	dcm_50to3 uut (
		.clkin(clk), 
		.clkout(clkout)
	);

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end  
  
endmodule
