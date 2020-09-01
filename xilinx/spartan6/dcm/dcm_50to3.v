`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Stephen Davies
// 
// Create Date:    01 Sep 2020 
// Target Devices: Spartan 6
// Tool versions:  ISE 14.7
// Description:    DCM usage example. Converts a 50MHz clock (clkin) to a 3MHz
//                 clock (clkout).
//
//////////////////////////////////////////////////////////////////////////////////
module dcm_50to3 (
    input clkin,
    output clkout
    );

   // DCM_CLKGEN: Frequency Aligned Digital Clock Manager
   //             Spartan-6
   // Xilinx HDL Language Template, version 14.7

   DCM_CLKGEN #(
      .CLKFXDV_DIVIDE(2),       // CLKFXDV divide value (2, 4, 8, 16, 32)
      .CLKFX_DIVIDE(50),        // Divide value - D - (1-256)
      .CLKFX_MD_MAX(0.0),       // Specify maximum M/D ratio for timing anlysis
      .CLKFX_MULTIPLY(3),       // Multiply value - M - (2-256)
      .CLKIN_PERIOD(20.0),      // Input clock period specified in nS
      .SPREAD_SPECTRUM("NONE"), // Spread Spectrum mode "NONE", "CENTER_LOW_SPREAD", "CENTER_HIGH_SPREAD",
                                // "VIDEO_LINK_M0", "VIDEO_LINK_M1" or "VIDEO_LINK_M2" 
      .STARTUP_WAIT("FALSE")    // Delay config DONE until DCM_CLKGEN LOCKED (TRUE/FALSE)
   )
   DCM_CLKGEN_inst (
      .CLKFX(clkout),        // 1-bit output: Generated clock output
      .CLKIN(clkin),         // 1-bit input: Input clock
      .FREEZEDCM(1'b0),      // 1-bit input: Prevents frequency adjustments to input clock
      .PROGCLK(1'b0),        // 1-bit input: Clock input for M/D reconfiguration
      .PROGDATA(1'b0),       // 1-bit input: Serial data input for M/D reconfiguration
      .PROGEN(1'b0),         // 1-bit input: Active high program enable
      .RST(1'b0)             // 1-bit input: Reset input pin
   );

endmodule
