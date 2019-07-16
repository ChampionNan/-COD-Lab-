`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 16:27:08
// Design Name: 
// Module Name: Sign_extend
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

//0:extend
module Sign_extend(
    input [15:0]sign_in,
    output [31:0]sign_out
    );
    //initial begin sign_out <= 0;end
    assign  sign_out = {{16{sign_in[15]}}, sign_in[15:0]};
endmodule
