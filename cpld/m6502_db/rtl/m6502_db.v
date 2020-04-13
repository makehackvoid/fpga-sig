`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Stephen Davies
// 
// Create Date:    18:35:10 27/02/2020 
// Design Name: 
// Module Name:    m6502_db
// Project Name: 
// Target Devices: Xilinx XC9536
// Tool versions:  Xilinx ISE 14.7
// Description:    6502 Debug and Test Tool
//
//                 Implements the static test control logic from
//                 Mostek's 6500 Hardware Manual pg. 125.
//
// Dependencies:   None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//                 The original schematic was a product of its times, using
//                 original TTL logic, i.e. not LS or HC etc. In the 1970's
//                 It was common to use inverting gates, NAND/NOR, and then use bubble
//                 logic, alternating between positive and negative logic expressions,
//                 through successive circuit stages.
//
//                 Because this design uses a CPLD and Verilog I've made the decision
//                 to use positive logic wherever possible and let ISE flip stuff around.
//////////////////////////////////////////////////////////////////////////////////
module m6502_db(
    input RESET_NO,            // RESET switch momentary contact (NO)
    input RESET_NC,            // RESET switch (NC)
    input RUN_N,               // Run/Halt toggle switch
    input HALT_N,              // Run/Halt toggle switch
    input PHI2,                // 6502 PHI2 clock
    input SYNC_N,              // 6502 SYNC, inversion due to Z50 bus (/M1)
    input SS_COM,              // Single cycle and single instruction momentary switches common
    input SI_NC,               // Single instruction switch (NC)
    input SC_NC,               // Single cycle switch (NC)
    input W_N,                 // 6502 R//W signal (aka Z50 bus /WR)
    output RESET_N,            // 6502 /RESET
    output RDY,                // 6502 RDY (aka Z50 bus /WAIT)
//    output LE,
    output LED_WR_N,           // WRITE LED (active low)
    output LED_SYN_N           // SYNC LED (active low)
    );

    wire sync;
    assign sync = ! SYNC_N;    // readability

    //
    // System reset section
    //
    // External SPDT momentary switch connects to a NAND RS latch.
    //
    wire reset;

    (* NOREDUCE = "TRUE"*)
    rs_latch reset_debounce (
        .s_n(RESET_NO),
        .r_n(RESET_NC),
        .q(reset));

    assign RESET_N = (reset) ? !reset : 1'bZ;  // Open drain

    //
    // Run/halt section, outputs 1 of 3 RDY signals (rdy_run)
    //
    // 1. Debounce an SPDT toggle switch using a NAND RS latch
    // 2. Feed into a clocked RS latch (flip flop) to synchronise
    //    with the CPU clock (phi2) signal
    //
    wire run, halt;
    wire gated_run, gated_halt;
    wire rdy_run;

    // 1. debounce
    (* NOREDUCE = "TRUE"*)
    rs_latch run_debounce (
        .s_n(RUN_N),
        .r_n(HALT_N),
        .q(run),
        .q_n(halt));

    // 2. clocked RS latch

    // NAND2 gate equiv - sets run_latch on run and phi2 falling edge 
    assign gated_run = run && ! PHI2;

    // NAND3 gate equiv - resets run_latch on halt and phi2 falling edge 
    //                    and sync (i.e. waits until next instruction before halting)  
    assign gated_halt = halt && ! PHI2 && sync;

    (* NOREDUCE = "TRUE"*)
    rs_latch run_latch (
        .s_n( ! gated_run),
        .r_n( ! gated_halt),
        .q(rdy_run));

    //
    // Single step section
    //
    // 1. Debounces two SPDT momentary switches using a 3 way NAND RS latch
    // 2. Feeds into the single step module
    //
    wire gated_set_n;
    wire single_step;    // High when either button pressed
    wire single_inst_n;  // Low when single instruction button pressed
    wire rdy_cycle;
    wire rdy_inst;
    wire wcycle;

    // Active (low) when switch pressed and phi2 low, sets 3 way debounce (ss_latch)
    assign gated_set_n = SS_COM || PHI2;

    // 1. debounce
    (* NOREDUCE = "TRUE"*)
    rs_latch3 ss_debounce (
        .r1_n(SC_NC),
        .s_n(gated_set_n),
        .r2_n(SI_NC),
        .q(single_step),
        .q2_n(single_inst_n)
    );

    // 2. single step module
    ss_core ss_mod (
        .phi2(PHI2),
        .sync(sync),
        .rd(W_N),
        .ss(single_step),
        .si_n(single_inst_n),
        .rdy_cycle(rdy_cycle),
        .rdy_inst(rdy_inst),
        .wcycle(wcycle)
    );

    //
    // Processor RDY signal is asserted when any of the 3 occur:
    // 1. Run/Halt switch is in the run position
    // 2. Single cycle button is pressed (for 1 phi2 cycle)
    assign RDY = rdy_run || rdy_cycle || rdy_inst;

    assign LED_SYN_N = ! (sync && ! wcycle);
    //assign LED_SYN_N = 1'b1;
    assign LED_WR_N = ! wcycle;
    //assign LED_WR_N = 1'b1;

endmodule
