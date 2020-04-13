`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Stephen Davies
// 
// Create Date:    19:27:27 27/02/2020 
// Design Name:    m6502_db
// Module Name:    rs_latch 
// Project Name: 
// Target Devices: Xilinx XC9500
// Tool versions:  Xilinx ISE 14.7
// Description:    A textbook RS latch implemented using NAND gates.
//                 Requires Verilog annotation -(* NOREDUCE = "TRUE"*).
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rs_latch(
    input s_n,
    input r_n,
    output q,
    output q_n
    );

    wire fb1, fb2;
	 
    nand u1 (fb1, s_n, fb2);
    nand u2 (fb2, r_n, fb1);
	 
    assign q = fb1;
    assign q_n = fb2;

endmodule
