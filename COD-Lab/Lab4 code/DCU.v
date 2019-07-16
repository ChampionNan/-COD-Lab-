`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 17:30:15
// Design Name: 
// Module Name: DCU
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


module DCU(
    input [15:0]vdata,
    input [7:0]x, y,
    input clk, rst,
    output reg [15:0]vaddr,
    output reg [3:0]disr, disg, disb,
    output hs, vs
    );
    wire en;
    wire [9:0] hc, vc;
    vgaSync vga(.clk(clk),.rst(rst),.hs(hs),.vs(vs),.videoen(en),.hc(hc),.vc(vc));
  always @(posedge clk) begin
          if(en == 1) begin
              if(hc < 513 && hc > 256 && vc < 513 && vc > 256)
                 if((x == hc-256 && (vc-256-y <= 2 || y-(vc-256) <= 2)) || (y == vc-256 && (hc-256-x <=2 || x-(hc-256) <= 2)))begin disr <= 0; disg <= 0;disb <= 0;end
                 else  begin 
                       vaddr <= (hc - 256 - 1) * 256 + (vc - 256) - 1;
                       disr <= vdata[11:8];
                       disg <= vdata[7:4];
                       disb <= vdata[3:0];
                       end
              else begin disr <= 0; disg <= 0; disb <= 0; end
              end
          else begin disr <= 0; disg <= 0; disb <= 0; end
          end
endmodule 

module vgaSync(input wire clk, rst,
    output reg hs,vs,videoen,output reg [9:0]hc, vc);
     reg vsenable;
     always @(posedge clk)
     begin
        if(rst == 1)
            hc<=0;
       else 
            begin
                if(hc == 10'd799)
                    begin
                        hc<=0;
                        vsenable<=1;
                    end
                else
                    begin
                        hc<=hc+1'b1;
                        vsenable<=0;
                    end
             end
      end
      
      always @ (*)
      begin
        if(hc < 10'd96)
        hs = 0;
        else hs = 1;
      end
      
      always @(posedge clk)
      begin
        if(rst == 1)
        vc<=0;
        else 
            if(vsenable == 1)
                begin
                    if(vc == 10'd520)
                        vc<=0;
                    else vc<=vc+1'b1;
                end
        end
        
       always @(*)
       begin
        if(vc<2) vs=0;
        else vs=1;
       end
       
       always @(*)
       begin
        if((hc<10'd784) && (hc>=10'd144) && (vc<10'd511) && (vc>=10'd31))
            videoen=1;
        else videoen=0;
        end
  endmodule

/*
module VGA(
    input clk, rst,
    output hs, vs, 
    output en, 
    output [15:0] x, y
    );
    parameter HD = 640, HF = 16, HS = 96, HB = 48;
    parameter VD = 480, VF = 10, VS = 2, VB = 31;
    
    reg ce;
    reg [15:0] count;
    reg [15:0] hc, vc;
    assign x = en ? hc : 0;
    assign y = en ? vc : 0;
    assign en = (hc < HD) && (vc < VD);
    assign hs = ~((hc >= HD + HF) && (hc < HD + HF + HS));
    assign vs = ~((vc >= VD + VF) && (vc < VD + VF + VS));
    always @(posedge clk) begin
        if(rst) {ce, count} <= 0;
        else {ce, count} <= count + 16'h4000;
    end
    always @(posedge clk) begin
        if(rst) begin
            hc <= 0;
            vc <= 0;
            end 
        else if (ce) begin
             if(hc >= HD + HF + HS + HB - 1)
                hc <= 0;
                if(vc >= VD + VF + VS + VB -1)
                    vc <= 0;
                else vc <= vc + 1;end
        else begin hc <= hc + 1;end
        end
        
endmodule
*/