`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 17:26:56
// Design Name: 
// Module Name: PCU
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
module paint_board(
    input [11:0]rgb,
    input [3:0]dirc,
    input draw,
    input clk_in, rst,
    output [3:0]disr, disg, disb,
    output hs,vs
    );
    wire clk;
    clk_wiz_0 first(
    .clk_out1(clk),
    .reset(rst),
    .clk_in1(clk_in));
    
    wire [15:0]paddr;
    wire [11:0]pdata;
    wire [7:0]x, y;
    wire [15:0]vaddr;
    wire [11:0]vdata;
    wire mclk;
    reg [1:0]count;
    always@(posedge clk)
    begin
    if(rst) count <= 0;
    else count <= count + 1'b1;
    end
    assign mclk = count[1];
    PCU pcu(.rgb(rgb),.dirc(dirc),.draw(draw),.clk(clk),.rst(rst),.paddr(paddr),.pdata(pdata),.x(x),.y(y));
    VRAM vram(.paddr(paddr),.pdata(pdata),.we(draw),.mclk(mclk),.vaddr(vaddr),.vdata(vdata));
    DCU dcu(.vdata(vdata),.x(x),.y(y),.clk(mclk),.rst(rst),.vaddr(vaddr),.disr(disr),.disg(disg),.disb(disb),.hs(hs),.vs(vs));
    endmodule 

module PCU(
    input [11:0]rgb,
    input [3:0]dirc,
    input draw, clk, rst,
    output [15:0]paddr,
    output [11:0]pdata,
    output reg [7:0]x,y
    );
    
     reg [31:0] clkdiv = 0;
     wire dclk;
         
         always @ (posedge clk or posedge rst)
         begin
           if(rst)
               clkdiv <= 0;
           else clkdiv<=clkdiv+1'b1;
         end
         
         assign dclk = clkdiv[20];
    
    always@(posedge dclk)//0:up; 1:left; 2:down; 3:rignt
    if(rst) begin x <= 8'b1000_0000;y <= 8'b1000_0000;end
    else begin
        if(draw) begin
            if(dirc[0] == 1 && y > 0) y <= y - 1;
            if(dirc[1] == 1 && x > 0) x <= x - 1;
            if(dirc[2] == 1 && y < 255) y <= y + 1;
            if(dirc[3] == 1 && x < 255) x <= x + 1;
        end
    end
    assign paddr = {x, y};
    assign pdata = rgb;
endmodule
