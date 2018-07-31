`timescale 1ns / 100ps

// Description: Flip flop set/reset playtime.
// Version: Vivado 2017.1
// File:    lab07_tb.v
// Author:  Stephen Davies
// Created: 31 July 2018
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

module lab07_tb;

    parameter PERIOD = 10;      // Clock period in ns

    reg                 clk;
    //reg                 ce;     // Clock enable
    reg                 reset;
    reg                 d;
    wire                qs;     // Output of synchronous FF
    wire                qa;     // Output of asynchronous FF

	initial begin
        clk = 1'b1;
	end

    // Clock has 50% duty cycle    
    always begin
        #(PERIOD/2) clk = ~clk;
    end

    // reset signal
    initial begin
        reset = 1'b1;
        #10.1 reset = 1'b0;
        #38   reset = 1'b1;
        #4    reset = 1'b0;
        #15   reset = 1'b1;
        #1    reset = 1'b0;
        #9   reset = 1'b1;
        #1    reset = 1'b0;
    end

    // data signal
    initial begin
        d = 1'b0;
        #18 d = 1'b1;
        #10 d = 1'b0;
        #10 d = 1'b1;
    end

    // TODO - instantiate a ff_07 instance here

    // Clock enable - applies to the 75-95ns timeline
    //initial begin
    //    ce = 1'b1;
    //    #78 ce = 1'b0;
    //    #10 ce = 1'b1;
    //end

endmodule
