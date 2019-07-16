`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 17:43:40
// Design Name: 
// Module Name: lab1-1
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


module ALU(
    input [5:0]a,
    input [5:0]b,
    input [2:0]oprd,
    input option,
    output reg [5:0]y,
    output reg [2:0]sign
    );
    
   // ‰»Î «≤π¬Î
    always@(*)
    begin
        case(oprd)
        3'b000:begin
            if(option == 0) begin
                if(a+b<64) begin y = a+b;sign = 3'b000;end
                else begin y = a+b-64;sign = 3'b001;end
                            end
            else begin
                if(a[5] == b[5]) begin y = a+b;
                    if(y[5] != a[5]) begin y = a+b-32;sign = 3'b010;end
                    else sign = 3'b000;end
                else begin 
                    y = a+b;
                    end
                end 
        end
        3'b001:begin
            if(option == 0) begin
                if(a<b) begin y = a+64-b;sign = 3'b001;end
                else begin y = a-b;sign = 3'b000;end end
            else begin
                if(a[5] == 1 && b[5] == 0) begin
                    y = a-b;
                    if(y[5] == 0) sign = 3'b010;
                    else sign = 3'b000;
                    end
                 if(a[5] == 0 && b[5] == 1) begin
                    y = a-b;
                    if(y[5] == 1) sign = 3'b010;
                    else sign = 3'b000;end
                 else begin y = a-b;sign = 3'b000;end
              end end
        3'b010:begin y[0] = a[0] && b[0];y[1] = a[1] && b[1];y[2] = a[2] && b[2]; y[3] = a[3] && b[3]; y[4] = a[4] && b[4];y[5] = a[5] && b[3];sign =2'b00;end
        3'b011:begin y[0] = a[0] | b[0]; y[1] = a[1] | b[1];y[2] = a[2] | b[2]; y[3] = a[3] | b[3];y[4] = a[4] | b[4];y[5] = a[5] | b[5];sign = 2'b00;end
        3'b100:begin y[0] = ~a[0];y[1] = ~a[1];y[2] = ~a[2];y[3] = ~a[3];y[4] = ~a[4];y[5] = ~a[5];sign = 2'b00;end
        3'b101:begin y[0] = b[0]^a[0];y[1] =b[1]^a[1];y[2] = b[2]^a[2];y[3] = b[3]^a[3];y[4] = b[4]^a[4];y[5] = b[5]^a[5];sign = 2'b00;end
        default: begin sign = 2'b00;end
        endcase
      end
endmodule
