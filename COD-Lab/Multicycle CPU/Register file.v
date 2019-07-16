`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 09:32:57
// Design Name: 
// Module Name: Register file
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


module Register_file(
    input [4:0]rads0,rads1,wads,outaddr,
    input [31:0]wdata,
    output [31:0]rdis0,rdis1,reg_data,
    input clk,rst,RegWrite
    );
    
    parameter NUM = 32,BIT = 32;
    reg [BIT-1:0]reg_files[NUM-1:0];
    integer i;
    
    
    always@(posedge clk or posedge rst)
    begin
        if(rst) begin
            //for(i = 0; i < NUM; i=i+1) reg_files[i] <= 0;
            reg_files[0] <= 0;
            reg_files[1] <= 0;
            reg_files[2] <= 0;
            reg_files[3] <= 0;
            reg_files[4] <= 0;
            reg_files[5] <= 0;
            reg_files[6] <= 0;
            reg_files[7] <= 0;
            reg_files[8] <= 0;
            reg_files[9] <= 0;
            reg_files[10] <= 0;
            reg_files[11] <= 0;
            reg_files[12] <= 0;
            reg_files[13] <= 0;
            reg_files[14] <= 0;
            reg_files[15] <= 0;
            reg_files[16] <= 0;
            reg_files[17] <= 0;
            reg_files[18] <= 0;
            reg_files[19] <= 0;
            reg_files[20] <= 0;
            reg_files[21] <= 0;
            reg_files[22] <= 0;
            reg_files[23] <= 0;
            reg_files[24] <= 0;
            reg_files[25] <= 0;
            reg_files[26] <= 0;
            reg_files[27] <= 0;
            reg_files[28] <= 0;
            reg_files[29] <= 0;
            reg_files[30] <= 0;
            reg_files[31] <= 0;
            end
        else 
        begin
        reg_files[0] <= 0;
        if(RegWrite == 1)reg_files[wads] <= wdata;
        end
    end
    assign rdis0 = reg_files[rads0];
    assign rdis1 = reg_files[rads1];
    assign reg_data = reg_files[outaddr];
endmodule
