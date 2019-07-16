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
//000:+     001:-   010:&   011:|   100:xor cuole, tian~~ «“ÏªÚ     101:nor

module ALU(
    input [31:0]a,
    input [31:0]b,
    input [2:0]oprd,
    input ifslt,
    output reg [31:0]y,
    output reg Zero
    );
    reg cf;
    always@(*)
    begin 
        case(oprd)
        3'b000:{cf, y} = {1'b0,a} + {1'b0,b};
        3'b001:begin if(ifslt == 0){cf, y} = a - b;else if(ifslt == 1) y = (a < b) ? 1 : 0; end
        3'b010:y = a & b;
        3'b011:y = a | b;
        3'b101:y = ~(a | b);
        3'b100:y = a ^ b;
        3'b110:Zero = (a == b) ? 1 : 0;//beq
        3'b111:Zero = (a != b) ? 1 : 0;//bnq
        endcase
      end
    //assign Zero = (a == b) ? 1 : 0;
endmodule
