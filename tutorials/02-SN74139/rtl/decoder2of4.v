`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    13:48:32 18/10/2019 
// Design Name:    decoder20f4
// Module Name:    decoder2of4 
// Project Name:   decoder2of4
// Target Devices: Any
// Tool versions:  Vivado 2017.1
// Description:    Verilog tutorial implementing half of an SN74139.
//
// Dependencies:   None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder2of4(
    input g_n,
    input a,
    input b,
    output [3:0] y_n
    );

    // Structural
	s139 u1 (
		.g_n(g_n), 
		.a(a), 
		.b(b), 
		.y_n(y_n)
	);

    // Dataflow
	//df139 u1 (
	//	.g_n(g_n), 
	//	.a(a), 
	//	.b(b), 
	//	.y_n(y_n)
	//);

    // Behavioural
	//b139 u1 (
	//	.g_n(g_n), 
	//	.a(a), 
	//	.b(b), 
	//	.y_n(y_n)
	//);

endmodule
