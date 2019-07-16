`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 10:26:04
// Design Name: 
// Module Name: FIFO_queue
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

  module FIFO_queue(
    input en_in,en_out,
    input [3:0]in,
    input rst,clk,enable,
    output reg [3:0]out,
    output reg [6:0]m,
    output reg [7:0]an,
    output reg Dot,
    output empty,full
    );
    wire clk_out1;
    clk_wiz_0 inst
      (
      .clk_out1(clk_out1),
      // Status and control signals               
      .reset(rst), 
     // Clock in ports
      .clk_in1(clk)
      );
      
    reg [15:0]cnt1;
    reg [2:0]pulse;
    always@(posedge clk_out1)//显示数码管
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
            /*
            cnt1 <= cnt1 + 15'd1;
            if(cnt1 == 15'd5000) pulse <= 3'b001;
            if(cnt1 == 15'd10000) pulse <= 3'b010;
            if(cnt1 == 15'd15000) pulse <= 3'b011;
            if(cnt1 == 15'd20000)pulse <= 3'b100;
            if(cnt1 == 15'd25000)pulse <= 3'b101;
            if(cnt1 == 15'd30000)pulse <= 3'b110;
            if(cnt1 == 15'd35000)pulse <= 3'b111;
            if(cnt1 == 15'd40000)begin pulse <= 3'b000;cnt1 <= 0;end*/
            end
      end
      
    reg [2:0]in_ptr,out_ptr,counter;
    reg [3:0]reg_files[15:0];
    reg [7:0]flag;//标志某一位是否有数字
    
    always@(posedge enable)
    if(rst)begin
        in_ptr = 0;
        out_ptr = 0;
        out = 0;
        counter = 0;
        flag = 0;
        end
    else
        case({en_out,en_in})
        2'b01:begin
                reg_files[in_ptr] = in;
                flag[in_ptr] = 1;
                counter = counter+1;
                in_ptr = (in_ptr == 7)?0:in_ptr+1;
              end
        2'b10:begin
                out = reg_files[out_ptr];
                flag[out_ptr] = 0;
                counter = counter - 1;
                out_ptr = (out_ptr == 7) ?0:out_ptr+1;
              end
        2'b11:begin
                if(counter == 0)out = in;
                else begin
                reg_files[in_ptr] = in;
                flag[in_ptr] = 1;
                out = reg_files[out_ptr];
                flag[out_ptr] = 0;
                in_ptr = (in_ptr == 7)?0:in_ptr+1;
                out_ptr = (out_ptr == 7)?0:out_ptr+1;
                end
              end
        endcase
    assign empty = (counter == 0 && flag[0] != 1);
    assign full = (counter == 0 && flag[0] == 1);
    
    always@(pulse)
    begin begin
        if(pulse == 0 && (flag[0] != 0))begin
        case(reg_files[0])
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
        4'd10:m = 7'b0000_001;
        4'd11:m = 7'b1001_111;
        4'd12:m = 7'b0010_010;
        4'd13:m = 7'b0000_110;
        4'd14:m = 7'b1001_100;
        4'd15:m = 7'b0100_100;
        endcase
        an = 8'b0111_1111;Dot = (out_ptr != 0)?1:0;end
        else if(pulse == 0 && flag[0] == 0) an = 8'b1111_1111;end
        
        begin
        if(pulse == 1 && (flag[1] != 0))begin
        case(reg_files[1])
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
            4'd10:m = 7'b0000_001;
            4'd11:m = 7'b1001_111;
            4'd12:m = 7'b0010_010;
            4'd13:m = 7'b0000_110;
            4'd14:m = 7'b1001_100;
            4'd15:m = 7'b0100_100;
          endcase
          an = 8'b1011_1111;Dot = (out_ptr != 1)?1:0;end
          else if(pulse == 1 && flag[1] == 0) an = 8'b1111_1111;end
          
          begin
          if(pulse == 2 && (flag[2] != 0))begin
          case(reg_files[2])
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
              4'd10:m = 7'b0000_001;
              4'd11:m = 7'b1001_111;
              4'd12:m = 7'b0010_010;
              4'd13:m = 7'b0000_110;
              4'd14:m = 7'b1001_100;
              4'd15:m = 7'b0100_100;
            endcase
            an = 8'b1101_1111;Dot = (out_ptr != 2)?1:0;end
            else if(pulse == 2 && flag[2] == 0) an = 8'b1111_1111;end
            
         begin
         if(pulse == 3 && (flag[3] != 0))begin
         case(reg_files[3])
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
                4'd10:m = 7'b0000_001;
                4'd11:m = 7'b1001_111;
                4'd12:m = 7'b0010_010;
                4'd13:m = 7'b0000_110;
                4'd14:m = 7'b1001_100;
                4'd15:m = 7'b0100_100;
           endcase
           an = 8'b1110_1111;Dot = (out_ptr != 3)?1:0;end
           else if(pulse == 3 && flag[3] == 0) an = 8'b1111_1111;end
        
         begin 
         if(pulse == 4 && (flag[4] != 0))begin
          case(reg_files[4])
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
               4'd10:m = 7'b0000_001;
               4'd11:m = 7'b1001_111;
               4'd12:m = 7'b0010_010;
               4'd13:m = 7'b0000_110;
               4'd14:m = 7'b1001_100;
               4'd15:m = 7'b0100_100;
          endcase
          an = 8'b1111_0111;Dot = (out_ptr != 4)?1:0;end
          else if(pulse == 4 && flag[4] == 0) an = 8'b1111_1111;end
          
          begin
          if(pulse == 5 && (flag[5] != 0))begin
          case(reg_files[5])
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
                  4'd10:m = 7'b0000_001;
                  4'd11:m = 7'b1001_111;
                  4'd12:m = 7'b0010_010;
                  4'd13:m = 7'b0000_110;
                  4'd14:m = 7'b1001_100;
                  4'd15:m = 7'b0100_100;
                  endcase
                  an = 8'b1111_1011;Dot = (out_ptr != 5)?1:0;end
              else if(pulse == 5 && flag[5] == 0) an = 8'b1111_1111;end
          
          begin       
          if(pulse == 6 && (flag[6] != 0))begin
          case(reg_files[6])
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
              4'd10:m = 7'b0000_001;
              4'd11:m = 7'b1001_111;
              4'd12:m = 7'b0010_010;
              4'd13:m = 7'b0000_110;
              4'd14:m = 7'b1001_100;
              4'd15:m = 7'b0100_100;
              endcase
              an = 8'b1111_1101;Dot = (out_ptr != 6)?1:0;end
              else if(pulse == 6 && flag[6] == 0) an = 8'b1111_1111;end
          begin
          if(pulse == 7 && (flag[7] != 0))begin
             case(reg_files[7])
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
             4'd10:m = 7'b0000_001;
             4'd11:m = 7'b1001_111;
             4'd12:m = 7'b0010_010;
             4'd13:m = 7'b0000_110;
             4'd14:m = 7'b1001_100;
             4'd15:m = 7'b0100_100;
             endcase
             an = 8'b1111_1110;Dot = (out_ptr != 7)?1:0;end
             else if(pulse == 7 && flag[7] == 0) an = 8'b1111_1111;end
        end 
endmodule
