`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    9/9/2020 
// Design Name:    sn74181
// Module Name:    sn74181
// Project Name:   sn74181 ALU
// Target Devices: Any
// Tool versions:  Vivado 2019.2
// Description:    Verilog tutorial implementing the SN74181 ALU.
//
// Based on Texas Instrument datasheet SDLS136 revised March 1988.
//
// To make things a little easier positive logic is used for the a and b signals.
// This means that operations are specified by table 2 in the datasheet.
//
// Designed using data-flow level equations. Use the logic diagram from page 5
// as a reference.
//
// Dependencies:   None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sn74181(
    input  [3:0] a,       // 4 bit input nybble
    input  [3:0] b,       // 4 bit input nybble
    input  [3:0] s,       // function select lines
    input        m,       // 0 = arithmetic, 1 = logic
    input        ci_n,
    output [3:0] f,
    output       a_eq_b
    );

    // Equations for first input layer i.e. the AND/NOR column at the
    // logic diagrams left hand side.
    // Reading top to bottom.

    // A3 & B3
    wire fab3_1, fab3_2;
    assign fab3_2 = ! (( a[3] &&  s[3] &&  b[3]) ||
                       ( a[3] &&  s[2] && !b[3]));
    assign fab3_1 = ! ((!b[3] &&  s[1]) ||
                       ( b[3] &&  s[0]) ||
                         a[3]);

    // A2 & B2
    wire fab2_1, fab2_2;
    assign fab2_2 = ! (( a[2] &&  s[3] &&  b[2]) ||
                       ( a[2] &&  s[2] && !b[2]));
    assign fab2_1 = ! ((!b[2] &&  s[1]) ||
                       ( b[2] &&  s[0]) ||
                         a[2]);

    // A1 & B1
    wire fab1_1, fab1_2;
    assign fab1_2 = ! (( a[1] &&  s[3] &&  b[1]) ||
                       ( a[1] &&  s[2] && !b[1]));
    assign fab1_1 = ! ((!b[1] &&  s[1]) ||
                       ( b[1] &&  s[0]) ||
                         a[1]);

    // A0 & B0
    wire fab0_1, fab0_2;
    assign fab0_2 = ! (( a[0] &&  s[3] &&  b[0]) ||
                       ( a[0] &&  s[2] && !b[0]));
    assign fab0_1 = ! ((!b[0] &&  s[1]) ||
                       ( b[0] &&  s[0]) ||
                         a[0]);

    wire [3:0] f_int;

    assign f_int[2] = ( (fab2_1 ^ fab2_2) ^
                       !((!m &&  ci_n &&  fab0_2) ||
                         (!m && ) ||
                         (!m &&  fab1_1))
                      );

    assign f_int[1] = ( (fab1_1 ^ fab1_2) ^
                       !((!m &&  ci_n &&  fab0_2) ||
                         (!m &&  fab0_1))
                      );

    assign f_int[0] = ( (fab0_1 ^ fab0_2) ^
                       !(!m && ci_n));

    assign a_eq_b = &f_int;
    assign f = f_int;

endmodule
