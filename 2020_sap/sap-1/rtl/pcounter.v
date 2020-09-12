`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    pcounter 
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
// Description:    Implements the program counter. This is done as a standalone
//                 module, rather than inline, so that a separate test bench can
//                 be used and studied.
//
//////////////////////////////////////////////////////////////////////////////////

module pcounter(
    input clk,          // System clock
    input cp,           // PC count enable
    input clr,          // Clear (reset)
    output [3:0] pc     // Program count
    );

    reg [3:0] count;

    always @(posedge clk or posedge clr)
        if (clr)
            count <= 0;
        else if (cp)
            count <= pc + 1;

    assign pc = count;
    
endmodule
