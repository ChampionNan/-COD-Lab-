`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 21:26:34
// Design Name: 
// Module Name: lab1_2
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
module lab1_1(
    input [5:0]a,
    input [5:0]b,
    input [2:0]oprd,
    input option,
    output reg [5:0]y,
    output reg [2:0]sign
    );
   
    always@(*)
    begin
        case(oprd)
        3'b000:begin
            if(option == 0) begin
                if(a+b<64) begin y = a+b;sign = 2'b00;end
                        else begin y = a+b-64;sign = 2'b01;end
                        end
            else begin
                if(a[5] == b[5]) begin y = a+b;
                    if(y[5] != a[5]) begin y = a+b-32;sign = 2'b10;end
                    else sign = 2'b00;end
                else begin y = a+b;
                    if(a+b<32)sign = 2'b00;
                    else sign = 2'b01;
                    end
                end 
        end
        3'b001:begin
            if(option == 0) begin
                if(a<b) begin y = a+64-b;sign = 2'b01;end
                else begin y = a-b;sign = 2'b00;end end
            else begin
                if(a[5] == 1 && b[5] == 0) begin
                    y = a-b;
                    if(y[5] == 0) sign = 2'b10;
                    else sign = 2'b00;
                     end
                 if(a[5] == 0 && b[5] == 1) begin
                    y = a-b;
                    if(y[5] == 1) sign = 2'b10;
                    else sign = 2'b00;end
                 if(a<b) begin y = a-b;sign = 2'b01;end
              end end
        3'b010:begin y[0] = a[0] && b[0];y[1] = a[1] && b[1];y[2] = a[2] && b[2]; y[3] = a[3] && b[3]; y[4] = a[4] && b[4];y[5] = a[5] && b[3];sign =2'b00;end
        3'b011:begin y[0] = a[0] | b[0]; y[1] = a[1] | b[1];y[2] = a[2] | b[2]; y[3] = a[3] | b[3];y[4] = a[4] | b[4];y[5] = a[5] | b[5];sign = 2'b00;end
        3'b100:begin y[0] = ~a[0];y[1] = ~a[1];y[2] = ~a[2];y[3] = ~a[3];y[4] = ~a[4];y[5] = ~a[5];sign = 2'b00;end
        3'b101:begin y[0] = b[0]^a[0];y[1] =b[1]^a[1];y[2] = b[2]^a[2];y[3] = b[3]^a[3];y[4] = b[4]^a[4];y[5] = b[5]^a[5];sign = 2'b00;end
        default: begin sign = 2'b00;end
        endcase
      end
endmodule

module Register_fibo(
    input [5:0]f0,
    input [5:0]f1,
    input reset,clk,
    output reg [5:0]b
    );
    wire [2:0]sign;
    reg [5:0]a;
    wire [5:0]y;
    lab1_1 DUT(.a(a),.b(b),.oprd(3'b000),.option(0),.y(y),.sign(sign));
    
     always@(posedge clk)
     begin
     if(reset == 0) begin a<=f0;b<=f1;end
     else begin a <= b;b<=y;end
    end
endmodule
