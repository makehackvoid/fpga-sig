`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    16:26:59 18/10/2019 
// Design Name:    decoder2of4
// Module Name:    df139 
// Project Name:   decoder2of4
// Target Devices: Any
// Tool versions:  Vivado 2017.1
// Description:    Implement a 74139 2 of 4 decoder using the dataflow level of
//                 abstraction.
//
// Dependencies:   None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module df139(
    input g_n,
    input a,
    input b,
    output [3:0] y_n
    );

    assign y_n[0] = !g_n & !b & !a;
    assign y_n[1] = !g_n & !b & a;
    assign y_n[2] = !g_n & b & !a;
    assign y_n[3] = !g_n & b & a;

endmodule
