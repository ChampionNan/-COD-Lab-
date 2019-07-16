`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Mux2_5bits
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


module Mux2_5bits(
    input [4:0]mux2_in0,mux2_in1,
    output [4:0]mux2_out,
    input RegDst
    );
    assign mux2_out = (RegDst == 1) ? mux2_in1 : mux2_in0;
endmodule
