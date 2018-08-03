`timescale 1ns / 1ps
`include "defines.vh"

// Description: AVR processor core.
// Version: Vivado 2017.1
// File:    avr_core.v
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

module avr_core(
    input               clk,
    input               reset,
    output  [3:0]       pc,             // program counter
    output [15:0]       instruction,    // current instruction
    output  [5:0]       opcode,         // current opcode
    output  [4:0]       rf1,            // register file port 1 address
    output  [4:0]       rf2,            // register file port 2 address
    output  [7:0]       a,              // ALU port A
    output  [7:0]       b,              // ALU port B
    output  [7:0]       sum             // ALU output
    );

    wire    [4:0]       rd;             // destination register (DR - 2 of 32 format)
    wire    [4:0]       rr;             // source register (DR - 2 of 32 format)
    
    // TODO - instantiate a program counter as U1

    // TODO - instantiate a program ROM as U2

    // Opcode is top 6 bits of the instruction
    assign opcode = instruction[15:10];

    // Register addresses from direct register format instructions     
    assign rd = instruction[8:4]; 
    assign rr = { instruction[9], instruction[3:0] };  // concatenation

    // TODO - instantiate a control ROM as U3

    assign rf1 = rd;
    assign rf2 = rr;
    
    // TODO - instantiate a register file as U4
    
    // TODO - instantiate a simplified ALU (logic) as U5

endmodule
