`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Make Hack Void
// Engineer:       Stephen Davies
// 
// Create Date:    8/12/2020 
// Design Name:    decoder2of4
// Module Name:    b139 
// Project Name:   decoder2of4
// Target Devices: Any
// Tool versions:  Vivado 2020.1
// Description:    Implement a 74139 2 of 4 decoder using the behavioural level of
//                 abstraction.
//
// Dependencies:   None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module b139(
    input g_n,
    input a,
    input b,
    output reg [3:0] y_n
    );

    always @*
        case ({g_n, b, a})
            3'b000  : y_n = 4'b1110;
            3'b001  : y_n = 4'b1101;
            3'b010  : y_n = 4'b1011;
            3'b011  : y_n = 4'b0111;
            default : y_n = 4'b1111;
        endcase

endmodule
