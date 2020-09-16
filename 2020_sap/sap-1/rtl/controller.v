`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    controller 
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
// Description:    Implements the controller/sequencer.
//
//////////////////////////////////////////////////////////////////////////////////

module controller(
    input            clk,     // System clock
    input            clr,     // Clear (reset)
    input [3:0]      inst,    // Instruction from IR (high order bits)
    output reg [6:1] t,       // Current machine T state
    output           mar_sel, // MAR mux select
    output           lm,      // MAR latch control
    output           cp,      // PC increment
    output           li,      // IR latch control
    output           a_sel,   // A reg mux - 0 = ram, 1 = alu
    output           la,      // A reg latch control
    output           lb,      // B reg latch control
    output           su,      // Select alu subtract function
    output           lo       // Output reg latch control
    );

    // Decoded instructions
    wire         lda, add, sub, out, halt;

    // Sequencer generating a series of T states,
    // implements the ring counter.
    // NB. FPGA's generally have D type, rather than JK flip flops.
    // TODO: kinda clunky, could be cleaner.
    always @(negedge clk)
        if (clr)
            t <= 6'b000000;
        else begin
            if (t == 0)
                t <= 6'b000001;
            else begin
                t[6:2] <= t[5:1];
                t[1] <= t[6];
            end
        end

    //
    // Control Matrix
    // --------------
    //

    // The MAR latch operates during T1 when it latches the PC and again
    // in T4 if the current instruction is LDA, ADD or SUB.
    assign lm = t[1] ||
                (t[4] && (lda || add || sub));

    // The A register latches either in T5 (LDA) or T6 (ADD and SUB)
    assign la = (t[5] && lda) ||
                (t[6] && (add || sub));

    // In T6 (ADD or SUB) the A reg takes its input from the adder/subtractor (alu)
    assign a_sel = t[6] && (add || sub);

    // The B register latches in T5 (ADD and SUB)
    assign lb = t[5] && (add || sub);

    // The output register latches in T4 (OUT)
    assign lo = t[4] && out;

    //
    // End Control Matrix
    // ------------------
    //

    // Instruction Decode
    // ------------------
    // Logically equivalent to the inverter/NAND gate matrix on
    // LHS of Fig 10-15.
    assign lda = (inst == 4'b0000);
    assign add = (inst == 4'b0001);
    assign sub = (inst == 4'b0010);
    assign out = (inst == 4'b1110);
    assign halt = (inst == 4'b1111);

    // Some signals only occur in certain T states
    assign cp = t[2];
    assign li = t[3];
    assign mar_sel = t[4];

    // Simple alias
    assign su = sub;

endmodule
