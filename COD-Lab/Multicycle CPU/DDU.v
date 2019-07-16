`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 21:52:58
// Design Name: 
// Module Name: DDU
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


module DDU(
    input count,step,mem,inc,dec,clk,rst,
    output [15:0]led,
    output reg [7:0]an,
    output reg [6:0]m
    );
    
    wire clk_out1;
    clk_wiz_0 clock(.clk_out1(clk_out1),.reset(rst),.clk_in1(clk));
    reg [1:0]state;
    parameter FSTAY = 2'b00, FIRST = 2'b01, SECOND = 2'b10;
    reg clk_en;
    always@(posedge clk_out1)
    begin
    if(rst) state <= FSTAY;
    else begin
        case(state)
        FSTAY:
            begin 
            clk_en <= 0;
            if(step) state <= FIRST;else state <= FSTAY;
            end
        FIRST:begin clk_en <= 1; state <= SECOND;end
        SECOND:
              begin
              clk_en <= 0;
              if(~step) state <= FSTAY;else state <= SECOND;
              end
          endcase
      end end
          
    wire [31:0] mem_data, reg_data, pc;
    reg [2:0]pulse;
    reg [15:0]cnt1;
       always@(posedge clk_out1)//ÏÔÊ¾ÊýÂë¹Ü
       begin
          if(rst)begin pulse <= 0;cnt1 <= 15'd0;end
           else begin
              cnt1 <= cnt1 + 16'd1;
              if(cnt1 == 15'd2500) pulse <= 3'b001;
              if(cnt1 == 15'd5000) pulse <= 3'b010;
              if(cnt1 == 15'd7500) pulse <= 3'b011;
              if(cnt1 == 15'd10000)pulse <= 3'b100;
              if(cnt1 == 15'd12500)pulse <= 3'b101;
              if(cnt1 == 15'd15000)pulse <= 3'b110;
              if(cnt1 == 15'd17500)pulse <= 3'b111;
              if(cnt1 == 15'd20000)begin pulse <= 3'b000;cnt1 <= 0;end
           end
      end
      
      reg [9:0]addrclkcnt;
      wire addrclk;
      always@(posedge pulse)
      begin
      if(rst) addrclkcnt <= 0;
      else addrclkcnt = addrclkcnt + 1;
      end
      
      assign addrclk = addrclkcnt[8];
            
      
  reg [7:0]addr;
      reg [1:0]astate;
      parameter STAY = 2'b00,INC = 2'b01, DEC = 2'b10;
      always@(posedge addrclk)
      begin
           if(rst) begin astate <= STAY;addr <= 0;end
            else begin
               case(state)
                    STAY:
                    begin 
                    if(inc == 1) begin astate <= INC; addr <= addr + 1;end 
                    else if(dec == 1)begin astate <= DEC;addr <= addr - 1;end
                    else astate <= STAY;
                    end
                    INC:begin if(inc == 0) astate <= STAY;else astate <= INC;end
                    DEC:begin if(dec == 0) astate <= STAY;else astate <= DEC;end
                endcase
                end
             end


     wire run, enable, newclk;
     wire [31:0]data; 
    assign led = {addr, pc[9:2]};
    //assign newclk = count ? (clk_out1) : (clk_out1 & clk_en);
    //assign newclk = count ? (pulse) : (pulse & clk_en);
    assign newclk = count ? (clk) : (clk & clk_en);
    CPU cpu(.enable(enable),.run(run),.clk(newclk),.rst(rst),.New_PC(pc),.mem_data(mem_data),.reg_data(reg_data),.addr(addr)); 
    assign data = (mem == 1) ? mem_data : reg_data;  
    wire [3:0]data0, data1, data2, data3, data4, data5, data6, data7;  
    assign data0 = data[31:28];
    assign data1 = data[27:24];
    assign data2 = data[23:20];
    assign data3 = data[19:16];
    assign data4 = data[15:12];
    assign data5 = data[11:8];
    assign data6 = data[7:4];
    assign data7 = data[3:0];
       
   
    always@(pulse)
    if(pulse == 0)begin
    case(data0)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b0111_1111;end
    else if(pulse == 1)begin
        case(data1)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1011_1111;end
     else if(pulse == 2)begin
        case(data2)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1101_1111;end
    else if(pulse == 3)begin
        case(data3)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1110_1111;end
    else if(pulse == 4)begin
        case(data4)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1111_0111;end
   else if(pulse == 5)begin
        case(data5)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1111_1011;end
    else if(pulse == 6)begin
        case(data6)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1111_1101;end
    else if(pulse == 7)begin
        case(data7)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
        an = 8'b1111_1110;end  
endmodule
/*
 module shumaguan(
    input [3:0]data,
    output reg [7:0]an,
    output reg [6:0]m
    );
    case(data)
        4'd0:m = 7'b0000_001;
        4'd1:m = 7'b1001_111;
        4'd2:m = 7'b0010_010;
        4'd3:m = 7'b0000_110;
        4'd4:m = 7'b1001_100;
        4'd5:m = 7'b0100_100;
        4'd6:m = 7'b0100_000;
        4'd7:m = 7'b0001_111;
        4'd8:m = 7'b0000_000;
        4'd9:m = 7'b0001_100;
        4'd10:m = 7'b1100_000;
        4'd11:m = 7'b1100_000;
        4'd12:m = 7'b0110_011;
        4'd13:m = 7'b1000_010;
        4'd14:m = 7'b0110_000;
        4'd15:m = 7'b0111_000;
        endcase
    an = 8'b0111_1111;
endmodule
*/