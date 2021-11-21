`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make, Hack, Void
// Engineer:       Stephen Davies
// 
// Create Date:    13:49:26 18/10/2019 
// Design Name:    s139
// Module Name:    s139 
// Project Name:   decoder2of4
// Tool versions:  ISE 14.7
// Description:    A structural/gate level implementation of a 2 of 4 decoder,
//                 i.e. half of a 74LS139.
//
//                 Gate structure is a direct copy of the Texas Instruments
//                 datasheet.
//////////////////////////////////////////////////////////////////////////////////

module s139(
    input g_n,
    input a,
    input b,
    output [3:0] y_n
    );

    wire g, a_n, b_n, a_buf, b_buf;
	 
    not u1 (g,   g_n);
    not u2 (a_n, a);
    not u3 (b_n, b);

    not u4 (a_buf, a_n);
    not u5 (b_buf, b_n);
	 
    nand u6 (y_n[0], g, a_n,   b_n);
    nand u7 (y_n[1], g, b_n,   a_buf);
    nand u8 (y_n[2], g, a_n,   b_buf);
    nand u9 (y_n[3], g, a_buf, b_buf);

endmodule
