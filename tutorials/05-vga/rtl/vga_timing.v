`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    21/11/2021 
// Description:    Verilog tutorial implementing VGA 640x480 timing.
//
//////////////////////////////////////////////////////////////////////////////////

module vga_timing(
    input pixel_clk,
    output vs,
    output hs,
    output [9:0] x,
    output [9:0] y
    );

    // VGA Timing parameters (constants)
    localparam HD = 640;    // Horizontal display area
    localparam HF = 16;     // Horizontal front porch
    localparam HS = 96;     // Horizontal sync pulse
    localparam HB = 48;     // Horizontal back porch
    localparam VD = 480;    // Vertical display area
    localparam VF = 10;     // Vertical front porch
    localparam VS = 2;      // Vertical sync pulse
    localparam VB = 33;     // Vertical back porch

    //
    // Horizontal timing generator
    //
    reg [9:0] hcount = 0;   // Horizontal up counter value, 0-799 
    wire      htop;         // Tick - horizontal counter has reached its max count (799)

    // Tick (pulse) for 1 clock cycle whenever hcount is at its maximum
    assign htop = hcount == (HD + HF + HS + HB - 1);

    always @(posedge pixel_clk)
        if (htop)
            hcount <= 0;           // Reset (new line)
        else
            hcount <= hcount + 1;  // Next pixel

    //
    // Vertical timing generator
    //
    reg [9:0] vcount = 0;   // Vertical up counter value, 0-524
    wire      vtop;         // Tick - vertical counter has reached its max count (524)
    
    // Ticks whenever vcount is at its maximum
    assign vtop = vcount == (VD + VF + VS + VB - 1);

    always @(posedge pixel_clk)
        if (vtop & htop)
            vcount <= 0;            // Reset (at end of last line on screen)
       else if (htop)
            vcount <= vcount + 1;   // Next line

    // Outputs:
    // Generate sync pulses (-ve polarity)
    assign hs = ! ((hcount >= HD + HF) & (hcount < HD + HF + HS));
    assign vs = ! ((vcount >= VD + VF) & (vcount < VD + VF + VS));
    assign x  = hcount;
    assign y  = vcount;

endmodule
