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

`ifndef _defines_vh_
`define _defines_vh_

//
// ALU Operation Codes
//
// Codes are 4 bits long. The two high order bits select the ALU sub-unit,
// for example MATH or LOGIC. The two low order bits are used within the sub-unit 
// to select the desired function, e.g. add or subtract.
//
// The ALU control value is the concatenation of the sub-unit select and
// sub-unit function values.
//

// sub-unit selection bits (high order)
`define ALU_MATH    2'b00
`define ALU_LOGIC   2'b01
`define ALU_SHIFT   2'b10
`define ALU_MISC    2'b11

// sub-unit function bits (low order)
// adder
`define ALUFN_ADD   2'b00
`define ALUFN_ADDC  2'b01
`define ALUFN_SUB   2'b10
`define ALUFN_SUBC  2'b11
// logic
`define ALUFN_AND   2'b00
`define ALUFN_OR    2'b01
`define ALUFN_XOR   2'b10
`define ALUFN_PASSB 2'b11
// shift
`define ALUFN_ASR   2'b00
`define ALUFN_LSR   2'b01
`define ALUFN_ROR   2'b10
// misc

// putting it all together...
`define ALUOP_ADD	{ `ALU_MATH, `ALUFN_ADD }
`define ALUOP_ADDC	{ `ALU_MATH, `ALUFN_ADDC }
`define ALUOP_SUB   { `ALU_MATH, `ALUFN_SUB }
`define ALUOP_SUBC  { `ALU_MATH, `ALUFN_SUBC }

`define ALUOP_AND   { `ALU_LOGIC, `ALUFN_AND }
`define ALUOP_OR    { `ALU_LOGIC, `ALUFN_OR }
`define ALUOP_XOR   { `ALU_LOGIC, `ALUFN_XOR }
`define ALUOP_PASSB { `ALU_LOGIC, `ALUFN_PASSB }

`define ALUOP_ASR   { `ALU_SHIFT, `ALUFN_ASR }
`define ALUOP_LSR   { `ALU_SHIFT, `ALUFN_LSR }
`define ALUOP_ROR   { `ALU_SHIFT, `ALUFN_ROR }

`define AMUX_RD     2'b00

//
// B Multiplexer values
//
`define BMUX_RR     2'b00
`define BMUX_K      2'b01
`define BMUX_1      2'b10

`endif // _defines_vh_
