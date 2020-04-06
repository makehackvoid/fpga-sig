`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Make, hack, void
// Engineer:      Stephen Davies
//
// Create Date:   14:33:54 06/04/2020
// Design Name:   sdram
// Module Name:   sdram_tb.v
// Project Name:  test1
// Target Device:  
// Tool versions:  
// Description:   Test the sdram_16bit module from opencores.org.
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sdram_tb;

    parameter PERIOD = 10;

	// Inputs
	reg clk;
	reg reset;
	reg stb_i;
	reg we_i;
	reg [3:0] sel_i;
	reg cyc_i;
	reg [31:0] addr_i;
	reg [31:0] data_i;

	// Outputs
	wire [31:0] data_o;
	wire stall_o;
	wire ack_o;
	wire sdram_clk_o;
	wire sdram_cke_o;
	wire sdram_cs_o;
	wire sdram_ras_o;
	wire sdram_cas_o;
	wire sdram_we_o;
	wire [1:0] sdram_dqm_o;
	wire [12:0] sdram_addr_o;
	wire [1:0] sdram_ba_o;

	// Bidirs
	wire [15:0] sdram_data_io;

	// Instantiate the Unit Under Test (UUT)
	sdram #(
        .SDRAM_MHZ(100),
        .SDRAM_READ_LATENCY(3)
    )
    uut(
		.clk_i(clk), 
		.rst_i(reset), 
		.stb_i(stb_i), 
		.we_i(we_i), 
		.sel_i(sel_i), 
		.cyc_i(cyc_i), 
		.addr_i(addr_i), 
		.data_i(data_i), 
		.data_o(data_o), 
		.stall_o(stall_o), 
		.ack_o(ack_o), 
		.sdram_clk_o(sdram_clk_o), 
		.sdram_cke_o(sdram_cke_o), 
		.sdram_cs_o(sdram_cs_o), 
		.sdram_ras_o(sdram_ras_o), 
		.sdram_cas_o(sdram_cas_o), 
		.sdram_we_o(sdram_we_o), 
		.sdram_dqm_o(sdram_dqm_o), 
		.sdram_addr_o(sdram_addr_o), 
		.sdram_ba_o(sdram_ba_o), 
		.sdram_data_io(sdram_data_io)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		stb_i = 0;
		we_i = 0;
		sel_i = 0;
		cyc_i = 0;
		addr_i = 0;
		data_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        reset = 1'b0;
	end

    always begin
        clk = 1'b1;
        #(PERIOD/2) clk = 1'b0;
        #(PERIOD/2);
    end  
      
endmodule

