`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void, Canberra, Australia
// Engineer:       Stephen Davies
// 
// Create Date:    05.09.2019 13:16:16
// Design Name:    Ricoh 2a03 Audio
// Module Name:    tri_channel
// Project Name: 
// Target Devices: Xilinx 7-series
// Tool Versions:  Vivado 2017.2
// Description:    Triangle waveform generator.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tri_channel(
    input clk,
    input reset,
    input [7:0] r1,     // linear counter controls                      ($4008)
    input [7:0] r3,     // wavelength LSB                               ($400A)
    input [7:0] r4,     // 7:3 length counter value, 2:0 wavelength MSB ($400B)
    output [10:0] p,    // debug value of prog_timer
    output tc,          // debug terminal count
    output [3:0] y
    );

   reg [10:0] prog_timer = {11{1'b0}};      // counts N downto 0 (divides clk by N+1)
   reg [4:0] step_gen = {5{1'b0}};          // counts 0 to 31, generates triangle waveform

   wire [10:0] N = {r4[2:0], r3};           // N ($400A-$400B)
   wire terminal_count;

   // Programmable down counter.
   // Divides 1.79MHz clock by 11 bit value in r3, r4 
   always @(posedge clk)
       if (reset)
          prog_timer <= 11'b0;
       else if (terminal_count)
          prog_timer <= N;
       else
          prog_timer <= prog_timer - 1'b1;

   assign p = prog_timer;
     
   // Terminal count occurs when prog_timer hits 0.
   // This will:
   // 1) cause prog_timer to reload its value for N
   // 2) Potentially trigger the step generator
   assign terminal_count = ~| prog_timer;
   assign tc = terminal_count;

   // Step generator is a simple 5 bit up counter.
   // Based on the available information it never reloads.
   always @(posedge clk)
      if (reset)
         step_gen <= 5'b0;
      else if (terminal_count)
         step_gen <= step_gen + 1;

   // A neat little trick is used here convert the 5 bit step_gen count into a 4 bit
   // triangle wave.
   // Counting from 00000 to 01111 it outputs 0 to F.
   // Once it hits 10000 the XNOR gates 'flip' the output.
   // Counting from 10000 to 11111 outputs F to 0.
   assign y[0] = ! ( step_gen[0] ^ step_gen[4] );
   assign y[1] = ! ( step_gen[1] ^ step_gen[4] );
   assign y[2] = ! ( step_gen[2] ^ step_gen[4] );
   assign y[3] = ! ( step_gen[3] ^ step_gen[4] );
   
endmodule
