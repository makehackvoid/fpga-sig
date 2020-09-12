`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    ram 
// Target Devices: Spartan 3
// Tool versions:  ISE 14.7
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
// Description:    Implements the program RAM.
//
//                 Missing the /CE signal on purpose due to FPGAs not
//                 supporting tri-state internally.
//
//////////////////////////////////////////////////////////////////////////////////

module ram(
    input [3:0] a,
    output [7:0] d
    );

    reg [7:0] data;

    always @(*)
        case (a)
            4'b0000: data = 8'b00001001;  // LDA 9H
            4'b0001: data = 8'b00011010;  // ADD AH
            4'b0010: data = 8'b00011011;  // ADD BH
            4'b0011: data = 8'b00101100;  // SUB CH
            4'b0100: data = 8'b11100000;  // OUT
            4'b0101: data = 8'b11110000;  // HLT
            4'b1001: data = 8'h10;        // 10H
            4'b1010: data = 8'h14;        // 14
            4'b1011: data = 8'h18;        // 18H
            4'b1100: data = 8'h20;        // 20H
            default: data = 8'b11111111;  // HLT
        endcase

    assign d = data;

endmodule
