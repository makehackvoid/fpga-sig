`timescale 1ns / 100ps
`include "defines.vh"

// Description: Unit test the ALU logic module.
// Version: Vivado 2017.1
// File:    logic_tb.v
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

module logic_tb;

    parameter TESTS = 8;                  // Number of unit tests

    integer        errors;                // # of failing tests
    integer        test;                  // current test #

    //
    // Test data - inputs and expected outputs
    //
	reg     [19:0] in_vec [TESTS-1:0];    // 4 bits ([19:16]) are ALU operation code
                                          // 8 bits ([15:8]) are ALU argument a
                                          // 8 bits ([7:0]) are ALU argument b
	reg     [11:0] out_vec [TESTS-1:0];   // 4 bits ([11:8]) are flags s, v, n, z
                                          // 8 bits ([7:0]) are sum (ALU output)
    
	// Inputs to logic module
    reg     [1:0]  fn;
    reg     [7:0]  a;
    reg     [7:0]  b;

	// Outputs from logic module
    wire    [7:0]  sum;
    wire    [3:0]  flags;    // s, v, n, z;

    reg            ok;

	// Instantiate the Unit Under Test (UUT)
	logic uut (
	    .fn(fn),
		.a(a),
		.b(b),
		.sum(sum),
		.s(flags[3]),
		.v(flags[2]),
		.n(flags[1]),
		.z(flags[0])
	);

    initial begin
        // Test 0 - AND 0 & 0                     - zero result, Z asserted
        in_vec[0] = { `ALUOP_AND, 8'h00, 8'h00 };
        out_vec[0] = { 4'b0001, 8'h00 };
        
        // Test 1 - AND 0xf0 & 0xa5               - mask off low order bits
        in_vec[1] = { `ALUOP_AND, 8'hf0, 8'ha5 };
        out_vec[1] = { 4'b1010, 8'ha0 };
        
        // Test 2 - OR 0 | 0                      - zero result, Z asserted
        in_vec[2] = { `ALUOP_OR, 8'h00, 8'h00 };
        out_vec[2] = { 4'b0001, 8'h00 };
        
        // Test 3 - OR 0x5a | 0xa5                - alternating 0's and 1's
        in_vec[3] = { `ALUOP_OR, 8'h5a, 8'ha5 };
        out_vec[3] = { 4'b1010, 8'hff };
        
        // Test 4 - OR 0x07 | 0x15                - some values overlap             
        in_vec[4] = { `ALUOP_OR, 8'h07, 8'h15 };
        out_vec[4] = { 4'b0000, 8'h17 };
        
        // Test 5 - XOR 0 ^ 0                     - zero result, Z asserted
        in_vec[5] = { `ALUOP_XOR, 8'h00, 8'h00 };
        out_vec[5] = { 4'b0001, 8'h00 };
        
        // Test 6 - XOR 0 ^ 0xff                  - invert all bits
        in_vec[6] = { `ALUOP_XOR, 8'h00, 8'hff };
        out_vec[6] = { 4'b1010, 8'hff };
        
        // Test 7 - XOR 0xff ^ 0xff               -- clear all bits
        in_vec[7] = { `ALUOP_XOR, 8'hff, 8'hff };
        out_vec[7] = { 4'b0001, 8'h00 };
    end

	initial begin
	   errors = 0;
	   $display($time, " << Starting simulation >>");
       #10;

       for (test = 0; test < TESTS; test = test + 1) begin
           fn = in_vec[test][17:16];    // Top 2 bits not required, already know this is for the logic unit
           a = in_vec[test][15:8];
           b = in_vec[test][7:0];

           #1;
	       if ((out_vec[test][11:8] == flags) && (out_vec[test][7:0] == sum))
               ok = 1'b1;
           else
               ok = 1'bx;
 
	       #9;
	       if (ok == 1'b1) begin
               $display($time, " Test %d ok", test);
           end
           else begin
               errors = errors + 1;
               $display($time, " *** ERROR - Test %d failed *** - cout (e)%b (a)%b, sum (e)%b (a)%b", test, out_vec[test][11:8], flags, out_vec[test][7:0], sum);
           end    
       end
       
       if (errors == 0) begin
           $display($time, " All good, beer o'clock?");
       end
    end

endmodule

