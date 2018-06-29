`timescale 1ns / 1ps

// Description: AVR sample program for workshop stage 1.
//              Introduces a minimal set of AVR operations.
//
//              LDI  - Load immediate, because you need to start somewhere
//              NOP  - No operation
//              AND  - AND of two registers
//              ANDI - AND of a register and an immediate value
//              OR   - OR of two registers
//              ORI  - OR of a register and an immediate value
//              EOR  - XOR of two registers
//              CLR  - Clear a register, special case of EOR
//              MOV  - Copy value from one register to another
//
// Version: Vivado 2017.1
// File:    prog1.v
// Author:  Stephen Davies
// Created: 21 May 2018
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

module prog1(
    input      [3:0]  a,      // address
    output reg [15:0] dout    // data out (instruction)
    );

    always @*
        case(a)
                                   // Stage 1.0
            4'h0: dout = 16'hea05; // ldi  r16,0xa5           ; r16 = 0xa5
            4'h1: dout = 16'he01f; // ldi  r17,0x0f           ; r17 = 0x0f
            4'h2: dout = 16'h2301; // and  r16,r17            ; r16 = 0x05
/*
                                   // Stage 1.1
            4'h3: dout = 16'h7f00; // andi r16,0xf0           ; r16 = 0
            4'h4: dout = 16'h2e00; // mov  r0, r16            ; r0  = 0
            4'h5: dout = 16'hea05; // ldi  r16,0xa5           ; r16 = 0xa5
            4'h6: dout = 16'hef1f; // ldi  r17,0xff           ; r17 = 0xff
            4'h7: dout = 16'h2e10; // mov  r1,r16             ; r1  = 0xa5
            4'h8: dout = 16'h2611; // eor  r1,r17             ; r1  = 0x5a
            4'h9: dout = 16'h2700; // clr  r16                ; r16 = 0
            4'ha: dout = 16'h2711; // clr  r17                ; r17 = 0
            4'hb: dout = 16'h6005; // ori  r16,0x05           ; r16 = 0x05
            4'hc: dout = 16'h6a10; // ori  r17,0xa0           ; r17 = 0xa0
            4'hd: dout = 16'h2b01; // or   r16,r17            ; r16 = 0xa5
*/
            default: dout = 16'h0000; // nop
        endcase

endmodule
