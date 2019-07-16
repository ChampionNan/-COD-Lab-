`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 17:28:22
// Design Name: 
// Module Name: VRAM
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


module VRAM(
    input [15:0]paddr,
    input [11:0]pdata,
    input we,mclk,
    input [15:0]vaddr,
    output [15:0]vdata
    );
    block_memory bm(.clka(mclk),.ena(1),.wea(we),.addra(paddr),.dina({4'b0000,pdata}),.clkb(mclk),.enb(1),.addrb(vaddr),.doutb(vdata));
    //ÈçºÎµü´ú£¿
endmodule
