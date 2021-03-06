`timescale 1ns / 1ps

// Description: Unit test the AVR core module.
// Version: Vivado 2017.1
// File:    pc_tb.v
// Author:  Stephen Davies
// Created: 29 June 2018
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

module avr_core_tb;

    parameter PERIOD = 10;     // Clock period in ns
    parameter PC_WIDTH = 4;    // Counter width in bits

    reg                 clk;
    reg                 reset;
    wire [PC_WIDTH-1:0] pc;            // program counter
    wire [15:0]         instruction;   // current instruction
    wire  [5:0]         opcode;        // high order instruction bits (6)
    wire  [4:0]         rf1;           // register 1 (R/W)
    wire  [4:0]         rf2;           // register 2 (R)
    wire  [7:0]         a;             // ALU input a
    wire  [7:0]         b;             // ALU input b
    wire  [7:0]         sum;           // ALU output
    
	initial begin
        clk = 1'b1;
	    reset = 1'b1;
	    #(1.01*PERIOD) reset = 1'b0;
	end
			
    always begin
        #(PERIOD/2) clk = ~clk;
    end

    avr_core DUT (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .opcode(opcode),
        .rf1(rf1),
        .rf2(rf2),
        .a(a),
        .b(b),
        .sum(sum)
    );

endmodule
