`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    11 Nov 2020 
// Design Name:    sap-1
// Module Name:    controller_tb
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
// Description:    Test the controller/sequencer.
//
//////////////////////////////////////////////////////////////////////////////////

module controller_tb;

    parameter PERIOD = 10;  // 10ns clk period = 100MHz

	// Inputs
	reg        clk;
	reg        clr;
    reg [3:0]  inst;

	// Outputs
	wire [6:1] t;
    wire       lm;
    wire       cp;
    wire       li;
    wire       mar_sel;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.clk(clk), 
		.clr(clr),
        .inst(inst),
		.t(t),
        .mar_sel(mar_sel),
        .lm(lm),
        .cp(cp),
        .li(li)
	);

	initial begin
		// Initialize Inputs
		clr = 1;

		// Wait 100 ns for global reset to finish
		#100;

        // remove clear (reset)
        clr = 0;
	end

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end  

endmodule
