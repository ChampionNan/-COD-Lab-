`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Instruction
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


module Instruction(
    input [31:0]in_instruction,
    output reg [5:0]Instruction31_26,
    output reg [4:0]Instruction25_21,Instruction20_16,
    output reg [15:0]Instruction15_0,
    input IRWrite,clk,rst
    );
    always@(posedge clk or posedge rst)
    if(rst)
    begin
     Instruction31_26 <= 0;
     Instruction25_21 <= 0;
     Instruction20_16 <= 0;
     Instruction15_0 <= 0;
    end
    else if(IRWrite) 
    begin
        Instruction31_26 <= in_instruction[31:26];
        Instruction25_21 <= in_instruction[25:21];
        Instruction20_16 <= in_instruction[20:16];
        Instruction15_0 <= in_instruction[15:0];
    end
                
endmodule
