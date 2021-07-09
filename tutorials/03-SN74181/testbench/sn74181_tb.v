`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    9/7/2021 
// Design Name:    sn74181_tb
// Module Name:    sn74181
// Project Name:   sn74181 ALU
// Target Devices: Any
// Tool versions:  Vivado 2020.2
// Description:    Testbench for Verilog based SN74181 ALU.
//
//////////////////////////////////////////////////////////////////////////////////
module sn74181_tb(
);

    // Test vector length calculation
    parameter S = 4;    // # selection bits
    parameter M = 1;    // Mode bit
    parameter CI = 1;   // Carry in
    parameter A = 4;
    parameter B = 4;
    parameter F = 4;    // Outputs
    parameter CO = 1;   // Carry out
    parameter X = 1;
    parameter Y = 1;
    parameter AEQB = 1;
    parameter N = S + M + CI + A + B + F + CO + X + Y + AEQB; // Test vector length
    parameter YL = F + CO + X + Y + AEQB; // Length of output data

    // Test vectors
    reg [N-1:0] testvectors [0:254];
    
    // Inputs
    reg [S-1:0]     s;
    reg             m, ci_n;
    reg [A-1:0]     a;
    reg [B-1:0]     b;

    // Outputs
    wire [F-1:0]    f;
    wire            co_n, x, y, aeqb;

    // Test variables
    reg             clk;
    reg [31:0]      i, errors;
    reg [YL-1:0]    expected;
    wire [YL-1:0]   q;

    sn74181 uut (
        .a(a), .b(b), .s(s), .m(m), .ci_n(ci_n),
        .f(f), .aeqb(aeqb), .x(x), .y(y), .co_n(co_n)
    );

    initial begin
        $readmemb("sn74181_tb.mem", testvectors);
        i = 0;
        errors = 0;
    end

    // generate clock
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // apply test vectors at rising edge of clock
    always @ (posedge clk)
    begin
        #1; {s, m, ci_n, a, b, expected} = testvectors[i];
    end

    assign q = { f, co_n, x, y, aeqb };
    
    // check results at falling edge of clock
    always @ (negedge clk)
    begin
        if (q !== expected) begin
            $display ("Error in vector: %d, inputs = %b_%b_%b_%b_%b", i, s, m, ci_n, a, b);
            $display (" outputs = %b (%b expected)", q, expected);
            errors = errors + 1;
        end
        //$display (" %b %b %b %b %b ", a, b, c, d, yexpected);
        i = i + 1;
        if (testvectors[i] === 22'bx) begin
            $display ("%d tests completed with %d errors", i, errors);

            $finish;
        end
    end

endmodule
