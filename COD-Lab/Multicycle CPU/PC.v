`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: PC
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


module PC(
    input pc_control,
    input [31:0]PC_in,
    output reg [31:0]PC_out,
    input rst,clk
    );
    always@(posedge clk or posedge rst)
    if(rst) PC_out <= 0;
    else begin
        if(pc_control) PC_out <= PC_in;
        else if(!pc_control)PC_out <= PC_out;
    end
endmodule
