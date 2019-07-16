`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 20:49:51
// Design Name: 
// Module Name: Lab2_2
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


module Lab2_2(
    input [3:0]x,y,
    input rst,clk,
    output reg [3:0]q,r,
    output reg error,done
    );
    reg [2:0]state, nextstate;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011,S4 = 3'b100,S5 = 3'b101,S6 = 3'b110,S7  =3'b111;
    
    reg [3:0]tempa,tempb;
    reg [7:0]temp_a,temp_b;
    integer i;
    
    always@(posedge clk)
    if(rst) begin state <= S0;tempa <= x;tempb <= y;end
    else state <= nextstate;
    
    wire [7:0]left;
    assign left = {temp_a[6:0],1'b0};
    
    always@(posedge clk)
        begin
            case(state)
                S0:begin error <= 0;done <= 0;temp_a <= {4'b0000,tempa};temp_b <= {tempb,4'b0000};end
                S1,S2,S3,S4:begin 
                    if(left[7:4] >= tempb) temp_a <= left-temp_b+1;
                    else temp_a <= left;
                   end
                S5:begin r <= temp_a[7:4];q <= temp_a[3:0];end
                S6:error <= 1;
                S7:done <= 1;
            endcase
        end
    always@(*)
            begin
                case(state)
                    S0:begin if(y!=0)nextstate = S1;else nextstate = S6;end
                    S1:nextstate = S2;
                    S2:nextstate = S3;
                    S3:nextstate = S4;
                    S4:nextstate = S5;
                    S5:nextstate = S7;
                    S6:nextstate = S6;
                    S7:nextstate = S7;
                endcase
            end
endmodule
