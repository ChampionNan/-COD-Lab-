`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Memory
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


module Memory(
    input [7:0]Address,
    input [31:0] Write_data,
    output [31:0]MemData,mem_data,
    input clk,
    input MemRead, MemWrite,
    input [7:0]addr
    );
    dist_mem_gen_0 mix_memory(.a(Address),.d(Write_data),.dpra(addr),.clk(clk),.we(MemWrite),.spo(MemData),.dpo(mem_data));
endmodule
