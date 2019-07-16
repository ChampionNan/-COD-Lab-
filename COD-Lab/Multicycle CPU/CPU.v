`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 21:55:58
// Design Name: 
// Module Name: CPU
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


module CPU(
    input enable,run,clk,rst,
    output [31:0]New_PC,mem_data,reg_data,//fuzhi
    input [7:0]addr
    );
    wire [31:0]PC_in;
    wire [31:0]PC;//PC:PC_in's out; PC0 multible driven's mux in before ALU
    wire [31:0]Address,MemData, out_data;
    wire [5:0]Instruction31_26;
    wire [4:0]Instruction25_21, Instruction20_16;
    wire [15:0]Instruction15_0;
    wire [4:0]Write_register; 
    wire [31:0]Wirte_data,Read_data1,Read_data2,Aout,Bout,a,b,sign_out,y,ALUOut_out;
    wire [31:0]out_left, out_left2;
    
    wire PCWriteCond, PCWrite, lorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst;//contrrol sign
    wire [1:0]PCSource,ALUSrcB;
    wire [1:0]ALUOp;
    wire [5:0]Opout;
    wire [2:0]I_sign;
    wire [2:0]oprd;
    wire Zero,ifslt;
    
    assign New_PC = PC;
   // PC pc_real(.pc_control((Zero && PCWriteCond) | PCWrite),.PC_in(PC_in),.run(run),.enable(enable),.PC_out(PC),.rst(rst));
   PC pc_real(.pc_control((Zero && PCWriteCond) | PCWrite),.PC_in(PC_in),.PC_out(PC),.rst(rst),.clk(clk));
    Mux2 ling(.mux2_in0(PC),.mux2_in1(ALUOut_out),.mux2_out(Address),.mux2_control(lorD));
    Memory memory(.Address(Address[9:2]),.Write_data(Bout),.MemData(MemData),.mem_data(mem_data),.clk(clk),.MemRead(MemRead),.MemWrite(MemWrite),.addr(addr));
    
    Instruction instruction_register(.in_instruction(MemData),.Instruction31_26(Instruction31_26),.Instruction25_21(Instruction25_21),.Instruction20_16(Instruction20_16),.Instruction15_0(Instruction15_0),
    .IRWrite(IRWrite),.clk(clk),.rst(rst));
    Memory_data_register data_register(.in_data(MemData),.out_data(out_data),.clk(clk));
    Mux2_5bits mux(.mux2_in0(Instruction20_16),.mux2_in1(Instruction15_0[15:11]),.mux2_out(Write_register),.RegDst(RegDst));
    Mux2 first(.mux2_in0(ALUOut_out),.mux2_in1(out_data),.mux2_out(Wirte_data),.mux2_control(MemtoReg));
    Register_file register(.rads0(Instruction25_21),.rads1(Instruction20_16),.wads(Write_register),.outaddr(addr[4:0]),.wdata(Wirte_data),.rdis0(Read_data1),.rdis1(Read_data2),.reg_data(reg_data),.clk(clk),.rst(rst),.RegWrite(RegWrite));
    
    Blocker A(.i_data(Read_data1),.clk(clk),.o_data(Aout));
    Blocker B(.i_data(Read_data2),.clk(clk),.o_data(Bout));
    
    //assign PC0 = PC;
    Mux2 second(.mux2_in0(PC),.mux2_in1(Aout),.mux2_out(a),.mux2_control(ALUSrcA));
    Sign_extend sign_extend(.sign_in(Instruction15_0),.sign_out(sign_out));
    Shift_left2 down(.in_left(sign_out),.out_left(out_left));
    Mux4 one(.mux4_in0(Bout),.mux4_in1(4),.mux4_in2(sign_out),.mux4_in3(out_left),.mux4_out(b),.ALUSrcB(ALUSrcB));
    
    ALU_control alu_control(.control_in(Instruction15_0),.ALUOp(ALUOp),.oprd(oprd),.ifslt(ifslt),.I_sign(I_sign),.Opout(Opout));
    ALU alu(.a(a),.b(b),.oprd(oprd),.ifslt(ifslt),.y(y),.Zero(Zero));
    Blocker aluout(.i_data(y),.clk(clk),.o_data(ALUOut_out));
    
    Shift_left2 up(.in_left({Instruction25_21,Instruction20_16,Instruction15_0}),.out_left(out_left2));
    Mux3 only(.mux3_in0(y),.mux3_in1(ALUOut_out),.mux3_in2({PC[31:28],out_left2}),.mux3_out(PC_in),.PCSource(PCSource),.rst(rst));
    
    Output_control control_center(.Op(Instruction31_26),.run(run),.enable(enable),.PCWriteCond(PCWriteCond),.PCWrite(PCWrite),.lorD(lorD),.MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),
    .IRWrite(IRWrite),.PCSource(PCSource),.ALUOp(ALUOp),.Opout(Opout),.ALUSrcB(ALUSrcB),.ALUSrcA(ALUSrcA),.RegWrite(RegWrite),.RegDst(RegDst),.clk(clk),.rst(rst),.I_sign(I_sign));
    
endmodule
