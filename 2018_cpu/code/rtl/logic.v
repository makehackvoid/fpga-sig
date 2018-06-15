`timescale 1ns / 1ps

// Description: Logic module for the ALU.
// Version: Vivado 2017.1
// File:    logic.v
// Author:  Stephen Davies
// Created: 20 May 2018
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

module logic(
    input       [1:0]   fn,           // selected function 
    input       [7:0]   a,            // argument 1
    input       [7:0]   b,            // argument 2
    output reg  [7:0]   sum,          // output
    output              s, v, n, z    // Sign, oVerflow, Negative and Zero flags
    );

    // Modify this procedure, extending the decoder logic i.e. more case items and statements
    always @*
        case (fn)
            default: sum = 8'b0;
        endcase
    // End modification

    // Flag logic, leave this bit alone
    assign s = sum[7];
    assign v = 1'b0;
    assign n = sum[7];
    assign z = ~| sum;

endmodule
