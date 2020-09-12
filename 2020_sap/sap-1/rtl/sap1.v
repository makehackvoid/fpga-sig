`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    sap-1 
// Target Devices: Spartan 3
// Tool versions:  ISE 14.7
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Description:    An FPGA implementation of Malvino & Brown's Simple as 
//                 Possible 1 (SAP-1) computer.
//
//                 Digital Computer Electronics
//                 Malvino, Albert Paul
//                 Jerald A Brown
//                 ISBN ???-?????
//
// Notes:          Because the original design was TTL based the polarity of
//                 various control signals is mixed depending upon, presumably,
//                 the polarity of the TTL chips used in their design.
//
//                 FPGAs, by their design, do not require high or low active
//                 signals so the convention used in this design is to opt
//                 for positive logic all through. That is, all latch enables
//                 etc. are active high.
//
//                 The M&B design uses a central bus and connects the various
//                 modules together using tri-state drivers. An excellent
//                 choice for TTL, however, this will not work inside an FPGA.
//                 FPGA's support tri-state in their I/O buffers (external
//                 connections) but not internally. The M&B circuit has been
//                 altered accordingly, in general this means using a multiplexor
//                 and running multiple signals, e.g. muxing the PC and IR
//                 into the RAM. See Verilog code for more details.
//
//////////////////////////////////////////////////////////////////////////////////

module sap1(
    input        clk,      // system clock
    input        clr,      // clear (reset)
    output [3:0] PC,       // PC value
    output [3:0] ADR,      // MAR latch output
    output [7:0] IR,       // IR latch output
    output [7:0] A,        // A register
    output [7:0] B,        // B register
    output       T1,       // T states...
    output       T2,
    output       T3,
    output       T4,
    output       T5,
    output       T6
    );

    reg    [3:0] mar;  // memory address register
    reg    [7:0] ir;   // instruction register

    wire       lm;
    wire       cp;
    wire       li;
    wire       su;
    wire       a_sel;
    wire [3:0] pc;
    wire [7:0] ram_data;
    wire [6:1] t;
    wire [7:0] alu_out;
    
    // Program counter
    pcounter program_counter (
        .clk(clk),
        .clr(clr),
        .cp(cp),
        .pc(pc)
    );

    // MAR - mux to select either PC output or IR low bits
    wire [3:0] mar_mux;
    wire       mar_sel;

    assign mar_mux = (mar_sel) ? ir[3:0] : pc;

    // MAR
    always @(posedge clk)
        if (lm)
            mar <= mar_mux;

    // RAM
    ram ram (
        .a(mar),
        .d(ram_data)
    );

    // Instruction register
    always @(posedge clk)
        if (clr)
            ir[7:4] <= 4'b0000;
        else if (li)
            ir <= ram_data;

    controller controller (
        .clk(clk),
        .clr(clr),
        .inst(ir[7:4]),
        .t(t),
        .mar_sel(mar_sel),
        .lm(lm),
        .cp(cp),
        .li(li),
        .a_sel(a_sel),
        .la(la),
        .lb(lb),
        .su(su)
    );

    // A register
    reg [7:0] a_reg;

    // A reg mux - select either ram_data or alu write back
    wire [7:0] a_mux;

    assign a_mux = (a_sel) ? alu_out : ram_data;
    
    always @(posedge clk)
        if (la)
            a_reg <= a_mux;

    // B register
    reg [7:0] b_reg;

    always @(posedge clk)
        if (lb)
            b_reg <= ram_data;

    // ALU
    assign alu_out = (su) ? a_reg - b_reg : a_reg + b_reg;

    assign PC = pc;
    assign ADR = mar;
    assign IR = ir;
    assign A = a_reg;
    assign B = b_reg;
    assign T1 = t[1];
    assign T2 = t[2];
    assign T3 = t[3];
    assign T4 = t[4];
    assign T5 = t[5];
    assign T6 = t[6];

endmodule
