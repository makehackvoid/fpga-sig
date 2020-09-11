`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    pcounter_tb
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
// Description:    Test the program counter.
//
//////////////////////////////////////////////////////////////////////////////////

module pcounter_tb;

    parameter PERIOD = 10;  // 10ns clk period = 100MHz

	// Inputs
	reg clk;
	reg cp;
	reg clr;

	// Outputs
	wire [3:0] pc;

	// Instantiate the Unit Under Test (UUT)
	pcounter uut (
		.clk(clk), 
		.cp(cp), 
		.clr(clr), 
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		cp = 0;
		clr = 1;

		// Wait 100 ns for global reset to finish
		#100;

        // remove clear (reset) and wait for another 100ns to show no change in pc
        clr = 0;
        #100;

        // At the 200ns mark the counter starts
        cp = 1;
	end

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end  

endmodule
