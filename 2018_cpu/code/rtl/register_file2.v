`timescale 1ns / 1ps

// Description: Dual port register file for AVR (alternate version).
//              Uses Xilinx specific RAM primitives.
// Version: Vivado 2017.1
// File:    register_file.v
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

module register_file2(
    input             clk,
    input             reset,
    input             we,
    input      [4:0]  add1,
    input      [4:0]  add2,
    input      [7:0]  din1,
    output     [7:0]  dout1,
    output     [7:0]  dout2
    );

    genvar n;
    generate
        for (n = 0; n < 8; n = n + 1)
        begin: bit

            // RAM32X1D: 32 x 1 positive edge write, asynchronous read dual-port
            //           distributed RAM (Mapped to a SliceM LUT6)
            //           Artix-7
            // Xilinx HDL Language Template, version 2018.1
        
            RAM32X1D #(
               .INIT(32'h00000000) // Initial contents of RAM
            ) RAM32X1D_inst (
                .DPO(dout2[n]),     // Read-only 1-bit data output
                .SPO(dout1[n]),     // Rw/ 1-bit data output
                .A0(add1[0]),       // Rw/ address[0] input bit
                .A1(add1[1]),       // Rw/ address[1] input bit
                .A2(add1[2]),       // Rw/ address[2] input bit
                .A3(add1[3]),       // Rw/ address[3] input bit
                .A4(add1[4]),       // Rw/ address[4] input bit
                .D(din1[n]),        // Write 1-bit data input
                .DPRA0(add2[0]),    // Read-only address[0] input bit
                .DPRA1(add2[1]),    // Read-only address[1] input bit
                .DPRA2(add2[2]),    // Read-only address[2] input bit
                .DPRA3(add2[3]),    // Read-only address[3] input bit
                .DPRA4(add2[4]),    // Read-only address[4] input bit
                .WCLK(clk),         // Write clock input
                .WE(we)             // Write enable input
           );
        
           // End of RAM32X1D_inst instantiation

        end
    endgenerate

endmodule
