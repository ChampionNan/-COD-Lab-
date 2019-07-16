`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Blocker
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


module Blocker(
    input [31:0]i_data,
    input clk,
    output reg [31:0]o_data
    );
    
    always@(posedge clk)
    begin o_data <= i_data;end
    //assign o_data = i_data;
endmodule
