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
    input [3:0]rads0,rads1,wads,wdata,
    output [3:0]rdis0,rdis1,
    input clk,rst
    );
    
    parameter NUM = 16,BIT = 4;
    reg [BIT-1:0]reg_files[NUM-1:0];
    integer i;
    
    always@(posedge clk or posedge rst)
    begin
        if(rst) begin
            //for(i = 0; i < NUM; i=i+1) reg_files[i] <= 0;
            reg_files[0] = 0;
            reg_files[1] = 0;
            reg_files[2] = 0;
            reg_files[3] = 0;
            reg_files[4] = 0;
            reg_files[5] = 0;
            reg_files[6] = 0;
            reg_files[7] = 0;
            reg_files[8] = 0;
            reg_files[9] = 0;
            reg_files[11] = 0;
            reg_files[12] = 0;
            reg_files[13] = 0;
            reg_files[14] = 0;
            reg_files[15] = 0;
            end
        else reg_files[wads] = wdata;
    end
    assign rdis0 = reg_files[rads0];
    assign rdis1 = reg_files[rads1];
endmodule
