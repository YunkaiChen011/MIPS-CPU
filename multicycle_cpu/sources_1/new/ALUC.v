`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 12:10:46
// Design Name: 
// Module Name: ALUC
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


module ALUC(
    input [5:0] op,
    input [5:0] in,
    input [1:0] aluop,
    output reg [2:0] aluctrl
    );
    initial aluctrl = 3'b000;
    always @ (*)
    begin
    if(aluop == 2'b00)//sw lw
        aluctrl = 3'b000;
    else if(aluop == 2'b01)//beq
        aluctrl = 3'b001;//sub
    else if(aluop == 2'b11)//bne
        aluctrl = 3'b111;
    else
    begin
        if(op == 6'b000000)
            case(in)
            6'b100000://add
            aluctrl = 3'b000;
            6'b100010://sub
            aluctrl = 3'b001;
            6'b100100://and
            aluctrl = 3'b010;
            6'b100101://or
            aluctrl = 3'b011;
            6'b100110://xor
            aluctrl = 3'b100;
            6'b100111://nor
            aluctrl = 3'b101;
            6'b101010://slt
            aluctrl = 3'b110;
            default:
            aluctrl = 3'b000;
            endcase
        else
            case(op)
            6'b001000://addi
            aluctrl = 3'b000;
            6'b001100://andi
            aluctrl = 3'b010;
            6'b001101://ori
            aluctrl = 3'b011;
            6'b001110://xori
            aluctrl = 3'b100;
            6'b001010://slti
            aluctrl = 3'b110;
            default:
            aluctrl = 3'b000;
            endcase
    end
    end
endmodule
