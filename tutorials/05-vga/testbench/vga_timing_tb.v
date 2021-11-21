`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    21/11/2021 
// Description:    Verilog tutorial implementing VGA 640x480 timing.
//
//////////////////////////////////////////////////////////////////////////////////

module vga_timing_tb();

    // 25.175MHz
    parameter PERIOD = 39;

    reg clk;

    wire hs, vs;
    wire [9:0] x, y;

    vga_timing uut (
        .pixel_clk(clk),
        .hs(hs),
        .vs(vs),
        .x(x),
        .y(y)
    );

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end
        
endmodule
