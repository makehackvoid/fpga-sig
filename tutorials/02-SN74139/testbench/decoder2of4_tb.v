`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Make Hack Void
// Engineer:      Stephen Davies
//
// Create Date:   14:02:18 18/10/2019
// Design Name:   decoder2of4
// Module Name:   decoder2of4_tb
// Project Name:  decoder2of4
// Target Device: Any
// Tool versions: Vivado 2017.1
// Description:   Verilog Test Fixture
//
// Dependencies:  None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decoder2of4_tb;

    // Inputs
    reg g_n, a, b;

    // Outputs
    wire [3:0] y_n;

    decoder2of4 u1 ( .g_n(g_n), .a(a), .b(b), .y_n(y_n) );

    initial begin
        // Device disabled      
        g_n = 1;
        b = 0; a = 0; #10;
        b = 0; a = 1; #10;
        b = 1; a = 0; #10;
        b = 1; a = 1; #10;

        // Device enabled      
        g_n = 0;
        b = 0; a = 0; #10;
        b = 0; a = 1; #10;
        b = 1; a = 0; #10;
        b = 1; a = 1; #10;
    end

endmodule
