`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 18:50:31
// Design Name: 
// Module Name: Lab2_1
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


module Lab2_1(
    input [3:0]x0,x1,x2,x3,
    input rst,clk,
    output reg [3:0]s0,s1,s2,s3
    //output reg done
    );
    reg [1:0]state,nextstate;
    parameter DATE0=3'b000,DATE1=3'b001,DATE2=3'b010,DATE3=3'b011,DATE4=3'b100,DATE5=3'b101;
    //wire [5:0]y;
    //wire [2:0]sign;
    reg [3:0]big1,big2,small1,small2,medium1,medium2;
    
    always@(posedge clk)
    if(rst) begin state <= DATE0;end
    else state <= nextstate;
    
    always@(posedge clk)
    begin
        case(state)
            DATE0:begin
               // lab1_1 Part11(.a({2'b00,x0}),.b({2'b00,x1}),.oprd(3'b001),.option(0),.y(y),.sign(sign));
                if(x0>=x1)begin big1 <= x0;small1 <= x1; end
                else if(x0<x1)begin big1 <= x1;small1 <= x0; end
               // lab1_1 Part12(.a({2'b00,x2}),.b({2'b00,x3}),.oprd(3'b001),.option(0),.y(y),.sign(sign));
               if(x2>=x3)begin big2 <= x2;small2 <= x3; end
               else if(x2<x3) begin big2 <= x3;small2 <= x2; end
               end
            DATE1:begin
               // lab1_1 Part21(.a({2'b00,big1}),.b({2'b00,big2}),.oprd(3'b001),.option(0),.y(y),.sign(sign));
                if(big1>=big2)begin s0 <= big1;medium1 <= big2;end
                else if (big1<big2)begin s0 <= big2;medium1 <= big1;end
                 // lab1_1 Part22(.a({2'b00,small1}),.b({2'b00,small2}),.oprd(3'b001),.option(0),.y(y),.sign(sign));
                 if(small1>=small2)begin medium2 <= small1;s3 <= small2;end
                 else if(small1<small2) begin medium2 <= small2;s3 <= small1;end
                end
           DATE2:begin
                //lab1_1 Part3(.a({2'b00,medium1}),.b({2'b00,medium2}),.oprd(3'b001),.option(0),.y(y),.sign(sign));
                if(medium1>=medium2)begin s1 <= medium1;s2 <= medium2;end
                else if(medium1<medium2)begin s1 <= medium2;s2 <= medium1;end
                end
           endcase
       end
       
       always@(state)
       begin
            case(state)
                DATE0:nextstate = DATE1;
                DATE1:nextstate = DATE2;
                DATE2:nextstate = DATE2;
                //DATE3:nextstate = DATE4;
                //DATE4:nextstate = DATE4;
            endcase
        end
endmodule
