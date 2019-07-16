`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: ALU_control
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


module ALU_control(
    input [15:0]control_in,
    input [1:0]ALUOp,
    output reg[2:0]oprd,
    output reg ifslt,
    input [2:0]I_sign,
    input [5:0]Opout
    );
    always@(*)
    begin
    if(ALUOp == 2'b00)
        begin 
        oprd = 3'b000;
        end
    else if(ALUOp == 2'b10)//R
        begin
        if(control_in[5:0] == 6'b100000) begin oprd = 3'b000;ifslt = 0;end//+
        else if(control_in[5:0] == 6'b100010) begin oprd = 3'b001;ifslt = 0;end//-
        else if(control_in[5:0] == 6'b100100) begin oprd = 3'b010;ifslt = 0;end//and
        else if(control_in[5:0] == 6'b100101) begin oprd = 3'b011;ifslt = 0;end//or
        else if(control_in[5:0] == 6'b100110) begin oprd = 3'b100;ifslt = 0;end//xor
        else if(control_in[5:0] == 6'b100111) begin oprd = 3'b101;ifslt = 0;end//nor
        else if(control_in[5:0] == 6'b101010) begin oprd = 3'b001;ifslt = 1;end//slt
        else begin oprd = 3'b000;ifslt = 0;end 
        end
    else if(ALUOp == 2'b01)//beq
        begin
        if(Opout == 6'b000100) oprd = 3'b110;
        else if(Opout == 6'b000101) oprd = 3'b111;
    end
    else if(ALUOp == 2'b11)
        begin
        if(Opout == 6'b001000) oprd = 3'b000;
        else if(Opout == 6'b001100) oprd = 3'b010;
        else if(Opout == 6'b001101) oprd = 3'b011;
        else if(Opout == 6'b001110) oprd = 3'b100;
        else if(Opout == 6'b001010) begin ifslt = 1;oprd = 3'b001;end
        end
    end
endmodule
