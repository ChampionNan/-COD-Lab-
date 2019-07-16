`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 16:42:49
// Design Name: 
// Module Name: lab1_3
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


module lab1_3(
    input [5:0]a,
    input clk,reset,
    output[5:0]y,
    output [2:0]sign
    );
    reg [5:0]b;
    lab1_1 DUT (.a(a),.b(b),.oprd(3'b000),.option(0),.y(y),.sign(sign));
    always@(posedge clk)
    if(reset == 0) b<=0;
    else b<=y;
endmodule
