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
    input        ci_n,    // carry in, active low
    output [3:0] f,       // alu out
    output       aeqb,    // A = B
    output       x,
    output       y,
    output       co_n     // carry out (Cn+4), active low
    );

    // Equations for first input layer i.e. the AND/NOR column at the
    // logic diagrams left hand side.
    wire   [3:0] p_n;
    wire   [3:0] g_n;
    genvar       i;

    for (i = 0; i < 4; i = i + 1) begin
        assign g_n[i] = ! (( a[i] &&  s[3] &&  b[i]) || ( a[i] &&  s[2] && !b[i]));
        assign p_n[i] = ! ((!b[i] &&  s[1]) || ( b[i] &&  s[0]) || a[i]);
    end

    // Equations for carry chain layer
    wire [3:0] f_int;
    wire       y_int;
    wire       z;         // part of carry chain, not really sure what it is

    assign y_int = (
                    !(
                        (p_n[3]) ||
                        (g_n[3] && p_n[2]) ||
                        (g_n[3] && g_n[2] && p_n[1]) ||
                        (g_n[3] && g_n[2] && g_n[1] && p_n[0])
                    )
                );

    assign z = !(ci_n && (&g_n));

    assign co_n = !(y_int && z);

    assign x = ! (&g_n);

    assign f_int[3] = (
                        (p_n[3] ^ g_n[3]) ^
                        !(
                            (!m &&  g_n[2] &&  g_n[1] &&  g_n[0] &&  ci_n) ||
                            (!m &&  p_n[0] &&  g_n[2] &&  g_n[1]) ||
                            (!m &&  p_n[1] &&  g_n[2]) ||
                            (!m &&  p_n[2])
                        )
                    );

    assign f_int[2] = (
                        (p_n[2] ^ g_n[2]) ^
                        !(
                            (!m &&  g_n[1] &&  g_n[0] &&  ci_n) ||
                            (!m &&  p_n[0] &&  g_n[1]) ||
                            (!m &&  p_n[1])
                        )
                    );

    assign f_int[1] = (
                        (p_n[1] ^ g_n[1]) ^
                        !(
                            (!m &&  g_n[0] &&  ci_n) ||
                            (!m &&  p_n[0])
                        )
                    );

    assign f_int[0] = (
                        (p_n[0] ^ g_n[0]) ^
                        !(!m && ci_n)
                    );

    assign y = y_int;
    assign f = f_int;
    assign aeqb = &f_int;

endmodule
