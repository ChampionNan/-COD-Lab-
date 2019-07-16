`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Mux4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux4(
    input [31:0]mux4_in0,mux4_in1,mux4_in2,mux4_in3,
    output reg [31:0]mux4_out,
    input [1:0]ALUSrcB
    );
    always@(*)
    case(ALUSrcB)
        2'b00:mux4_out = mux4_in0;
        2'b01:mux4_out = mux4_in1;
        2'b10:mux4_out = mux4_in2;
        2'b11:mux4_out = mux4_in3;
    endcase
endmodule
