`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:20:00 04/12/2020
// Design Name:   m6502_db
// Module Name:   ss_core_tb
// Project Name:  m6502_debug
// Target Device: Xilinx XC9500
// Tool versions: Xilinx ISE 14.7
// Description: 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module ss_core_tb;

    parameter PERIOD = 1000;

    reg phi2;
    reg sync;
    reg rd;
    reg ss;
    reg si_n;
    reg sc;   // doco only

    wire rdy_cycle, rdy_inst;
    wire wc_clk;
    wire wc;
    wire [1:3] delay;

    ss_core uut(
        .phi2(phi2),
        .sync(sync),
        .rd(rd),
        .ss(ss),
        .si_n(si_n),
        .rdy_inst(rdy_inst),
        .rdy_cycle(rdy_cycle),
        .wcycle_clk(wc_clk),
        .wcycle(wc),
        .delay(delay)
    );
    
    initial begin
        // Initialize Inputs
        rd = 1;
        sc = 1;
        ss = 0;
        si_n = 1;
        sync = 0;

        // Wait 1000 ns for global reset to finish
        #1000;

        // Initial single cycle step - ignored due to wc FF not yet set
        sc = 0;
        ss = 1;
        #3000;
        sc = 1;
        ss = 0;
        #2000;

        // Initial single cycle step - ignored due to wc FF not yet set
        sc = 0;
        ss = 1;
        #1000;
        sync = 1;
        #2000;
        sc = 1;
        ss = 0;
        #2000;

        // Step instruction
        si_n = 0;
        ss = 1;
        #1000;
        sync = 0;

        #2000;
        sync = 1;
        #1000;
        si_n = 1;
        ss = 0;
        #3000;

        //
        // Simulate a PHP instruction HM A 5.1
        // T0 - read OPCODE (already there)
        // T1 - read OPCODE (discarded)
        // T2 - write
        sc = 0;
        ss = 1;
        #1000;
        sync = 0;
        #2000;
        sc = 1;
        ss = 0;
        #3000;

        sc = 0;  // step through T1
        ss = 1;
        #1000;
        rd = 0;  // indicate T2 start
        #2000;
        sc = 1;
        ss = 0;
        #3000;

        // Check to see if single cycle button is now locked out
        sc = 0;
        ss = 1;
        #1000;

    end

    always begin
        phi2 = 1'b0;
        #(PERIOD/2) phi2 = 1'b1;
        #(PERIOD/2);
    end  
     
endmodule
