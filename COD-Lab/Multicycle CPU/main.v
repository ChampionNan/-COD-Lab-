`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 21:46:01
// Design Name: 
// Module Name: main
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


module main(
    input count,step,mem,inc,dec,
    input [31:0]PC,mem_data,reg_data,
    output run,enable,
    output [31:0]addr,
    output [15:0]led,
    output [7:0]an,
    output [6:0]m
    );
endmodule
