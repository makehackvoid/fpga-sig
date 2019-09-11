`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        MakeHackVoid Canberra, Australia
// Engineer:       Stephen Davies 
// 
// Create Date:    19:55:04 11 Sep 2019 
// Design Name: 
// Module Name:    blink
// Project Name: 
// Target Devices: Spartan 6
// Tool versions: 
// Description:    Blink example for the QM Tech XC6SLX16_SDRAM board.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module blink(
    input CLK,
    output [1:0] LED
    );

    reg [23:0] count = 0;
	 
    always @ (posedge CLK)
        count <= count + 1;

    assign LED = count[23:22];
	 
endmodule
