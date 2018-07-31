`timescale 1ns / 1ps

// Description: Testbench for the AVR register file.
// Version: Vivado 2017.1
// File:    register_file_tb.v
// Author:  Stephen Davies
// Created: 2 July 2018
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

module register_file_tb;

    parameter PERIOD = 10;     // Clock period in ns
    parameter PC_WIDTH = 4;    // Counter width in bits
    parameter REG_COUNT = 32;  // Number of registers
    
    integer             i;
    reg                 ok;    // Test flag
    
    reg                 clk;
    reg                 reset;
    reg                 we;    // write enable
    reg  [4:0]          add1,  // port 1 - address
                        add2;  // port 2 - address
    reg  [7:0]          din1;  // port 1 - data in
    wire [7:0]          dout1, // port 1 - data out
                        dout2; // port 2 - data out

    // Instantiate device under test (DUT)
    register_file DUT (
        .clk(clk),
        .reset(reset),
        .we(we),
        .add1(add1),
        .add2(add2),
        .din1(din1),
        .dout1(dout1),
        .dout2(dout2)
    );

    // Never ending clock signal at 50% duty cycle			
    always begin
        #(PERIOD/2) clk = ~clk;
    end

    // One time initialisation i.e. reset pulse
	initial begin
        clk = 1'b1;
	    reset = 1'b1;
	    #(1.01*PERIOD) reset = 1'b0;       // manually forced hold time
	end

    // Test initialisation
    initial begin
        ok = 1'bx;                         // RED
        we = 1'b0;                         // reads first
        add1 = 0;
        add2 = 0;
        din1 = 0;
        $display($time, " << Starting simulation >>");
    end
    
    // Test sequence #1
    // Verify all registers have been reset (zeroed out).
    // Register file is dual ported so we can read two registers
    // simultaneously (in parallel), e.g. r0 and r1.
    // Timeline is 20-180ns.
    initial begin
        #(2*PERIOD);                       // get clear of one time initialisation

        // Loop increments by 2 i.e. 0, 2, 4 etc.        
        for (i = 0; i < REG_COUNT; i = i + 2) begin
            add1 = i;                      // even register
            add2 = i + 1;                  // odd register
            
            #2                             // Allow for propagation delay (RF access time)
            if ((dout1 == 8'd0) && (dout2 == 8'd0))
                ok = 1'b1;
            else begin
                ok = 1'bx;
                $display($time, " *** ERROR - Non-zero value found *** - i %d dout1 %b dout2 %b ", i, dout1, dout2);
            end
            
            #(PERIOD-2);                   // Fudge to keep test sequence in sync with clock period
        end
     end
     
     // Test sequence #2
     // Tests read/write operations 
     // Writes a value into port 1 and then reads it back on the next cycle via port 2
     // Value written is the register number i.e r0 = 0, r1 = 1 etc.
     // Timeline starts at 190ns
     initial begin
        #189 we = 1'b1;                    // assert write enable
        #1;                                // align with clock edge

        // Step through r1-r31
        // So for first iteration r1 is write, r0 is read      
        for (i = 1; i < REG_COUNT; i = i + 1) begin
            #1                             // fudge propagation delay
            add1 = i;                      // select write register e.g. r1
            add2 = i - 1;                  // register written on previous iteration e.g. r0
            din1 = i;                      // value to write e.g. 1
            
            #2;                            // allow some settling time
            
            // check data value matches register number
            if (dout2 == (i - 1))
                ok = 1'b1;
            else begin
                ok = 1'bx;
                $display($time, " *** ERROR - Screwy data write *** - i %d dout2 %b ", i, dout2);
            end
            
            #(PERIOD-3);                   // Fudge to keep test sequence in sync with clock period
        end

        we = 1'b0;
        
    end
    
endmodule
