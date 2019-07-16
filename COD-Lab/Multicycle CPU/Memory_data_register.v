`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Memory_data_register
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


module Memory_data_register(
    input [31:0]in_data,
    output reg [31:0]out_data,
    input clk
    );
    
    always@(posedge clk)
    begin out_data <= in_data;end
    //assign out_data = in_data;
endmodule
