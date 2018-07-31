`timescale 1ns / 100ps

// Description: Flip flop playtime.
// Version: Vivado 2017.1
// File:    lab06_tb.v
// Author:  Stephen Davies
// Created: 30 July 2018
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

module lab06_tb;

    parameter PERIOD = 10;      // Clock period in ns

    reg                 clk;
    reg                 d;
    reg                 q;
    
	initial begin
        clk = 1'b1;
        d = 1'b0;
	end

    // Clock has 50% duty cycle    
    always begin
        #(PERIOD/2) clk = ~clk;
    end

    // Stimulus matches example shown in workshop slides
    initial begin
        #7   d = 1'b1;
        #10  d = 1'b0;
        #10  d = 1'b1;
        #5   d = 1'b0;
        #4   d = 1'b1;
        #2   d = 1'b0;
        #4   d = 1'b1;
        #4   d = 1'b0;
    end

    always @(posedge clk)
        q <= d;

endmodule
