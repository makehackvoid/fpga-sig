`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Stephen Davies 
// 
// Create Date:    15:51:09 12/04/2020 
// Design Name:    m6502_db
// Module Name:    rs_latch3 
// Project Name: 
// Target Devices: Xilinx XC9500
// Tool versions:  Xilinx ISE 14.7
// Description:    
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rs_latch3(
    input r1_n,
    input s_n,
    input r2_n,
    output q1_n,
    output q,
    output q2_n
    );

    wire fb1, fb2, fb3;
	 
    nand u1 (fb1, r1_n, fb2);
    nand u2 (fb2, s_n, fb1, fb3);
    nand u3 (fb3, r2_n, fb2);
	 
    assign q1_n = fb1;
    assign q = fb2;
    assign q2_n = fb3;

endmodule
