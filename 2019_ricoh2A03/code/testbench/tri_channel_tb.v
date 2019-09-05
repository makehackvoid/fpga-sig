`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void, Canberra, Australia
// Engineer:       Stephen Davies
// 
// Create Date:    05.09.2019 14:05:56
// Design Name:    Ricoh 2a03 Audio
// Module Name:    tri_channel_tb
// Project Name: 
// Target Devices: Xilinx 7-series
// Tool Versions:  Vivado 2017.2
// Description:    Triangle waveform generator testbench.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tri_channel_tb();

   parameter PERIOD = 558;  // 1.79 MHz

   reg clk;                 // 1.79 MHz

   wire [10:0] p;           // debug the programmable timer
   wire tc;                 // debug terminal count
   wire [3:0] tri_y;        // 4 bit triangle wave
  
   always begin
      clk = 1'b1;
      #(PERIOD/2) clk = 1'b0;
      #(PERIOD/2);
   end

   tri_channel dut (.clk(clk), .reset(1'b0), .r1(8'd0), .r3(8'd126), .r4(8'd0), .p(p), .tc(tc), .y(tri_y));

endmodule
