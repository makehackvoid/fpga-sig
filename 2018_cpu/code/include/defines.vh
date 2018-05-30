// Description: Human readable constants.
// Version: Vivado 2017.1
// File:    defines.vh
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

//
// ALU Operation Codes
//
`define ALUOP_ADD	4'b0000
`define ALUOP_ADDC	4'b0001
`define ALUOP_SUB   4'b0010
`define ALUOP_SUBC  4'b0011

`define ALUOP_AND   4'b0100
`define ALUOP_OR    4'b0101
`define ALUOP_XOR   4'b0110

`define ALUOP_ASR   4'b1000
`define ALUOP_LSR   4'b1001
`define ALUOP_ROR   4'b1010

`define ALUOP_PASSB 4'b1100


`define AMUX_RD     2'b00

//
// B Multiplexer values
//
`define BMUX_RR     2'b00
`define BMUX_K      2'b01
`define BMUX_1      2'b10
