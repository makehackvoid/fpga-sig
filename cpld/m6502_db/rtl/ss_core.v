`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Stephen Davies
// 
// Create Date:    21:31:08 12/04/2020 
// Design Name: 
// Module Name:    ss_core 
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
module ss_core(
    input phi2,           // 6502 PHI2 clock
    input sync,           // 6502 SYNC signal
    input rd,             // 6502 R//W signal
    input ss,             // Single step, active high
    input si_n,           // Single step instruction, active low
    output wcycle_clk,
    output wcycle,
    output rdy_cycle,     // RDY for a single cycle
    output rdy_inst,      // RDY until the next instruction
    output [1:3] delay
    );

    wire single_instruction;
    assign single_instruction = ! si_n;  // readability

    //
    // The single step module is stateful, driven primarily by the
    // ss, si_n and phi2 inputs.
    //
    // There is a chain of 3 D type FF's, wired up as a shift register.
    // It stores delayed versions of the ss input:
    // 000 - both buttons up
    // 100 - either button down (cycle 1)
    // 110 - either button down (cycle 2)
    // 111 - either button down (cycles 3+)
    // 011 - button released    (cycle 1)
    // 001 - button released    (cycle 2)
    reg [1:3] ss_delayed = 3'b000;

    always @(negedge phi2) begin
        ss_delayed[1] <= ss;
        ss_delayed[2] <= ss_delayed[1];
    end

    always @(posedge phi2) begin
        ss_delayed[3] <= ss_delayed[2];
    end

    // Assert the RDY signal so long as the SINGLE INSTRUCTION button is pressed and 
    // the 6502 has not yet cycled to the next instruction fetch.
    assign rdy_inst = ss_delayed[1] && ! sync && single_instruction;

    //
    // Mongrel FF at bottom of schematic appears to set/reset around read/write cycles.
    // It doesn't seem to work the way the manual describes it. Implementing it the same
    // way as the schematic. Maybe I'll nut it out in the future.
    //
    reg wc_n;
    wire wc_clk;
    wire wc_preset;

    assign wc_clk = (rd || ! phi2) || single_instruction;

    // Asserted during button down cycle 2
    assign wc_preset = ss_delayed[2] && ! ss_delayed[3];

    always @(posedge wc_preset or posedge wc_clk) begin
        if (wc_preset)
            wc_n <= 1'b1;
        else
            wc_n <= 1'b0;
    end

    assign rdy_cycle = ss_delayed[1] && ! ss_delayed[2] && wc_n;

    assign wcycle_clk = wc_clk;
    assign wcycle = ! wc_n;
    assign delay = ss_delayed;

endmodule
