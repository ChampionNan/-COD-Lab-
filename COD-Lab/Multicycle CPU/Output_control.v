`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Output_control
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


module Output_control(
    input [5:0]Op,
    input run, enable,
    output reg PCWriteCond,PCWrite,lorD,MemRead,MemWrite,MemtoReg,IRWrite,
    output reg [1:0]PCSource,
    output reg [1:0]ALUOp,
    output [5:0]Opout,
    output reg [1:0]ALUSrcB,
    output reg ALUSrcA,RegWrite,RegDst,
    input clk, rst,
    output reg [2:0]I_sign
    );
    assign Opout = Op;
    reg [3:0]state, nextstate;
    parameter Fetch = 4'b0000, Decode = 4'b0001, Address_compute = 4'b0010, Memory_access_R = 4'b0011, Write_back = 4'b0100, Memory_access_W = 4'b0101, Execution = 4'b0110;
    parameter R_complete = 4'b0111, Branch_complete = 4'b1000, Jump_complete = 4'b1001, Imediate_compute = 4'b1010,Imediate_complete = 4'b1100,NBranch_complete = 4'b1011;     
    parameter Begin = 4'b1111; 
    
    always@(posedge clk)
    if(rst) state <= Fetch;
    else state <= nextstate;
    always@(*)
    begin
        case(state)
        Begin: begin MemRead = 0; ALUSrcA = 0; lorD = 0; IRWrite = 0; ALUSrcB = 2'b00; ALUOp = 2'b00;PCWrite = 0;PCSource = 2'b00;RegDst = 0;end
        Fetch:
        begin 
        MemRead = 1; ALUSrcA = 0; lorD = 0; IRWrite = 1; ALUSrcB = 2'b01; ALUOp = 2'b00;PCWrite = 1;PCSource = 2'b00;RegDst = 0;RegWrite = 0;MemWrite = 0;
        end
        Decode: begin ALUSrcA = 0; ALUSrcB = 2'b11; ALUOp = 2'b00;IRWrite = 0;PCWrite = 0;PCWriteCond = 0;end
        Imediate_compute:
        begin 
        ALUSrcA = 1;ALUSrcB = 2'b10;ALUOp = 2'b11;//I_sign = 0;
        end
        Address_compute:
        begin ALUSrcA = 1; ALUSrcB = 2'b10; ALUOp = 2'b00;
        end
        Memory_access_R:begin MemRead = 1;lorD = 1;end
        Write_back:begin RegDst = 0; RegWrite = 1; MemtoReg = 1;end
        Memory_access_W:begin MemWrite = 1; lorD = 1;end
        Execution:begin ALUSrcA = 1; ALUSrcB = 2'b00; ALUOp = 2'b10; end
        Imediate_complete:begin RegDst = 0;RegWrite = 1;MemtoReg = 0;end
        R_complete:begin RegDst = 1; RegWrite = 1; MemtoReg = 0;end
        Branch_complete:begin ALUSrcA = 1; ALUSrcB = 2'b00; ALUOp = 2'b01; PCWriteCond = 1; PCSource = 2'b01;end
        NBranch_complete:begin ALUSrcA = 1;ALUSrcB = 2'b00;ALUOp = 2'b01;PCWriteCond = 1;PCSource = 2'b01;end
        Jump_complete:begin PCSource = 2'b10;PCWrite = 1;end
        endcase
    end
    
    always@(*)
    begin
        case(state)
        Begin:nextstate = Fetch;
        Fetch:nextstate = Decode;
        Decode:
            begin 
            if(Op == 6'b001000 | Op == 6'b001100 | Op == 6'b001101 | Op == 6'b001110 | Op == 6'b001010) nextstate = Imediate_compute; //I
            else if(Op == 6'b100011 | Op == 6'b101011) nextstate = Address_compute;//lw+sw
            else if(Op == 6'b000000) nextstate = Execution; //R
            else if(Op == 6'b000100) nextstate = Branch_complete;//beq
            else if(Op == 6'b000101) nextstate = NBranch_complete;
            else if(Op == 6'b000010) nextstate = Jump_complete;//jump
            //else nextstate = Fetch;
            end
        Imediate_compute:nextstate = Imediate_complete;
        Address_compute:
            begin
            if(Op == 6'b001000 | Op == 6'b001100 | Op == 6'b001101 | Op == 6'b001110 | Op == 6'b001010) nextstate = Imediate_compute;
            else if(Op == 6'b100011) nextstate = Memory_access_R;
            else if(Op == 6'b101011) nextstate = Memory_access_W;
            //else nextstate = Fetch;
            end
        Memory_access_R:nextstate = Write_back;
        Write_back:nextstate = Fetch;
        Memory_access_W:nextstate = Fetch;
        Execution:nextstate = R_complete;
        Imediate_complete:nextstate = Fetch;
        R_complete:nextstate = Fetch;
        Branch_complete:nextstate = Fetch;
        NBranch_complete:nextstate = Fetch;
        Jump_complete:nextstate = Fetch;
        endcase
    end
endmodule
