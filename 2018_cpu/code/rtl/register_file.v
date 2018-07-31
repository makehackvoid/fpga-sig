`timescale 1ns / 1ps

// Description: Dual port register file for AVR.
// Version: Vivado 2017.1
// File:    register_file.v
// Author:  Stephen Davies
// Created: 22 May 2018
//
// Copyright (c) 2018 Stephen Davies
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

module register_file(
    input             clk,
    input             reset,
    input             we,
    input      [4:0]  add1,
    input      [4:0]  add2,
    input      [7:0]  din1,
    output     [7:0]  dout1,
    output     [7:0]  dout2
    );

   reg [7:0] regfile [31:0];

   assign dout1 = regfile[add1];
   assign dout2 = regfile[add2];

   always @(posedge clk)
       if (reset) begin
	       regfile[0] <= 0;  regfile[1] <= 0;  regfile[2] <= 0;  regfile[3] <= 0;
	       regfile[4] <= 0;  regfile[5] <= 0;  regfile[6] <= 0;  regfile[7] <= 0;
	       regfile[8] <= 0;  regfile[9] <= 0;  regfile[10] <= 0; regfile[11] <= 0;
	       regfile[12] <= 0; regfile[13] <= 0; regfile[14] <= 0; regfile[15] <= 0;
	       regfile[16] <= 0; regfile[17] <= 0; regfile[18] <= 0; regfile[19] <= 0;
	       regfile[20] <= 0; regfile[21] <= 0; regfile[22] <= 0; regfile[23] <= 0;
	       regfile[24] <= 0; regfile[25] <= 0; regfile[26] <= 0; regfile[27] <= 0;
	       regfile[28] <= 0; regfile[29] <= 0; regfile[30] <= 0; regfile[31] <= 0;
      end 
      else if (we)
	           regfile[add1] <= din1;

endmodule
