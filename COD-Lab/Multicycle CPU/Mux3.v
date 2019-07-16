`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Mux3
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


module Mux3(
    input [31:0]mux3_in0,mux3_in1,mux3_in2,
    output reg [31:0]mux3_out,
    input [1:0]PCSource,
    input rst
    );
    always@(*)
    begin
    //if(rst) mux3_out = 0;
    begin
        case(PCSource)
            2'b00:mux3_out = mux3_in0;
            2'b01:mux3_out = mux3_in1;
            2'b10:mux3_out = mux3_in2;
        endcase
    end 
    end
    //assign mux3_out = (
endmodule
