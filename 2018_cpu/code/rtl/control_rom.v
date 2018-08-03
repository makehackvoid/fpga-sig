`timescale 1ns / 1ps
`include "defines.vh"

// Description: AVR instruction decode ROM.
// Version: Vivado 2017.1
// File:    control_rom.v
// Author:  Stephen Davies
// Created: 3 August 2018
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

module control_rom(
    input  [5:0]  opcode,        // 6 high order bits from instruction
    output        we_ctrl,       // write register file enable
    output [1:0]  alu_ctrl,      // ALU operation
    output        rdmux_ctrl,    // immediate mode instruction, force 1dddd
    output        bmux_ctrl      // ALU port B select
    );

    reg [0:4] data;
  
    always @*
        casez(opcode)
            //                  we,   aluop,        rdmux, bmux
            6'b1110??: data = { 1'b1, `ALUFN_PASSB, 1'b1,  1'b1 }; // ldi
            6'b001000: data = { 1'b1, `ALUFN_AND,   1'b0,  1'b0 }; // and
            default:   data = { 1'b0, `ALUFN_PASSB, 1'b0,  1'b0 }; // nop
        endcase

    assign we_ctrl    = data[0];
    assign alu_ctrl   = data[1:2];
    assign rdmux_ctrl = data[3];
    assign bmux_ctrl  = data[4];
     
endmodule
