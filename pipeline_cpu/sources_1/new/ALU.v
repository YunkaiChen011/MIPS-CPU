`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 21:13:25
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,
    input [31:0] b,
    input [2:0] sel,
    output zero,
    output reg [31:0] y
    );
    assign zero = y == 0 ? 0 : 1;
    always@ (*)
    begin
    case(sel[2:0])
        3'b000://add
        y = a + b;
        3'b001://sub
        y = a - b;
        3'b010://and
        y = a & b;
        3'b011://or
        y = a | b;
        3'b100://xor
        y = a ^ b;
        3'b101://nor
        y = ~(a | b);
        3'b110://slt
        begin
        if(a[31] == 0 && b[31] == 1)
            y = 0;
        else if(a[31] == 1 && b[31] == 0)
            y = 1;
        else
            y = a < b ? 1 : 0;
        end
        default:
        y = a + b;
        endcase
        end
endmodule
