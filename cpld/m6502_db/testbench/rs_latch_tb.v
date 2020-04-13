`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:29:27 02/27/2020
// Design Name:   rs_latch
// Module Name:   C:/Users/sjdavies/Xilinx/m6502_debug/rs_latch_tb.v
// Project Name:  m6502_debug
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rs_latch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rs_latch_tb;

	// Inputs
	reg s_n;
	reg r_n;

	// Outputs
	wire q;
	wire q_n;

	// Instantiate the Unit Under Test (UUT)
	rs_latch uut (
		.s_n(s_n), 
		.r_n(r_n), 
		.q(q), 
		.q_n(q_n)
	);

	initial begin
		// Initialize Inputs
		s_n = 1;
		r_n = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Set
      s_n = 0;
		#100;
      s_n = 1;
		#100;
		
		// reset
      r_n = 0;
		#100;
      r_n = 1;
		#100;
		
	end
      
endmodule

