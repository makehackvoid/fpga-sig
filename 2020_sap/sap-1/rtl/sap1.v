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
//                 ISBN 0-02-800594-5
//                 https://archive.org/download/367026792DigitalComputerElectronicsAlbertPaulMalvinoAndJeraldABrownPdf1/367026792-Digital-Computer-Electronics-Albert-Paul-Malvino-and-Jerald-A-Brown-pdf%20%281%29.pdf
//
// Notes:          Because the original design was TTL based, the polarity of
//                 various control signals is mixed depending upon, presumably,
//                 the polarity of the TTL chips used in their design.
//
//                 FPGAs, by their design, do not require high or low active
//                 signals so the convention used in this design is to opt
//                 for positive logic throughout. That is, all control signal
//                 such as latch enables etc. are active high.
//
//                 The M&B design uses a central bus and connects the various
//                 modules together using tri-state drivers. An excellent
//                 choice for TTL, however, this will not work inside an FPGA.
//                 FPGA's support tri-state in their I/O buffers (external
//                 connections) but not internally. The M&B circuit has been
//                 altered accordingly, in general this means using a multiplexer
//                 and running multiple signals, e.g. muxing the PC and IR
//                 into the RAM. See Verilog code for more details.
//
//////////////////////////////////////////////////////////////////////////////////

module sap1(
    input        clk,      // System clock
    input        clr,      // Clear (reset)
    output [3:0] PC,       // PC value
    output [3:0] MAR,      // MAR latch output
    output [7:0] IR,       // IR latch output
    output [7:0] A,        // A register
    output [7:0] B,        // B register
    output [7:0] OUT,      // Output register
    output       T1,       // T states...
    output       T2,
    output       T3,
    output       T4,
    output       T5,
    output       T6
    );

    // Signals that map directly to M&B's design
    reg [3:0]    mar;      // Memory Address Register (MAR)
    reg [7:0]    ir;       // Instruction Register (IR)
    reg [7:0]    a_reg;    // Accumulator A
    reg [7:0]    b_reg;    // Accumulator B
    reg [7:0]    out_reg;  // Output Register

    wire         lm;       // MAR latch
    wire         cp;       // PC count enable
    wire         li;       // IR latch
    wire         su;       // Subtract
    wire         lo;       // Output register latch
    wire [7:0]   alu_out;  // Adder/subtractor output
    wire [6:1]   t;        // T states in vector format. T1 = t[1] etc.
    wire [3:0]   pc;       // Program counter output
    wire [7:0]   ram_data; // RAM output

    // Signals not in the original M&B design
    wire [3:0]   mar_mux;  // Output from MAR mux, input to RAM
    wire         mar_sel;  // MAR mux select line - 0 = PC, 1 = IR
    wire [7:0]   a_mux;    // Output from accum A mux
    wire         a_sel;    // Accum A mux select line
    
    // Program counter
    // ---------------
    // Changed from M&B design, output enable (Ep) has been removed due to no W bus.
    pcounter program_counter (
        .clk(clk),
        .clr(clr),
        .cp(cp),
        .pc(pc)
    );

    // MAR input mux
    // -------------
    // Not in original design. Replaces W bus.
    // Selects either PC (T1) or IR low order bits (T4).
    assign mar_mux = (mar_sel) ? ir[3:0] : pc;

    // Memory Address Register (MAR)
    // -----------------------------
    // Latches on clk rising edge when lm true. Same as M&B.
    always @(posedge clk)
        if (clr)
            mar <= 0;
        else if (lm)
            mar <= mar_mux;

    // 16x8 RAM
    // --------
    // Changed from M&B design, chip enable (/CE) has been removed due to no W bus.
    ram ram (
        .a(mar),
        .d(ram_data)
    );

    // Instruction register (IR)
    // -------------------------
    // Changed from M&B design, ram_data direct connect due to no W bus.
    always @(posedge clk)
        if (clr)
            ir[7:4] <= 4'b0000;
        else if (li)
            ir <= ram_data;

    // Controller/Sequencer
    // --------------------
    // See controller.v for detail.
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
        .su(su),
        .lo(lo)
    );

    // Accumulator A input mux
    // -----------------------
    // Not in original design. Replaces W bus.
    // Selects either ram_data (LDA in T5) or ALU output (ADD/SUB in T6).
    assign a_mux = (a_sel) ? alu_out : ram_data;
    
    // Accumulator A
    // -------------
    // Changed from M&B design, due to no W bus.
    // Input is taken from the A mux.
    // Latch control same as M&B.
    always @(posedge clk)
        if (clr)
            a_reg <= 0;
        else if (la)
            a_reg <= a_mux;

    // Adder/Subtractor (a basic ALU) 
    // ------------------------------
    // Changed from M&B design. Verilog handles add/sub without having to
    // resort to full adders or XOR inversion. Result will still be the same.
    assign alu_out = (su) ?
                     a_reg - b_reg   // SUB
                   : a_reg + b_reg;  // ADD

    // Accumulator B
    // -------------
    // Changed from M&B design. No W bus so it takes its input direct from the RAM.
    // With SAP-1 this is the only possible datapath. 
    // Latch control same as M&B.
    always @(posedge clk)
        if (clr)
            b_reg <= 0;
        else if (lb)
            b_reg <= ram_data;

    // Output Register
    // ---------------
    // Changed from M&B design. No W bus so it takes its input directly from
    // accumulator A. 
    always @(posedge clk)
        if (clr)
            out_reg <= 0;
        else if (lo)
            out_reg <= a_reg;

    assign PC = pc;
    assign MAR = mar;
    assign IR = ir;
    assign A = a_reg;
    assign B = b_reg;
    assign OUT = out_reg;

    // T state breakout
    assign T1 = t[1];
    assign T2 = t[2];
    assign T3 = t[3];
    assign T4 = t[4];
    assign T5 = t[5];
    assign T6 = t[6];

endmodule
