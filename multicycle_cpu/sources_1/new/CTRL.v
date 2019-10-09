`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 01:40:18
// Design Name: 
// Module Name: CTRL
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


module CTRL(
    input [5:0] op,
    input clk,
    input rst,
    output reg PCWriteCond,
    output reg PCWrite,
    output reg lorD,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,
    output reg [1:0] PCSource,
    output reg [1:0] ALUOp,
    output reg ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg RegWrite,
    output reg RegDst
    );
    reg [3:0] state;
    reg [3:0] nextstate;
    initial
    begin
    state = 4'b0000; 
    PCWriteCond = 0;
    MemRead = 1;
    IRWrite = 1;
    lorD = 0;
    PCWrite = 1;
    MemWrite = 0;
    PCSource = 2'b00;
    ALUSrcA = 0;
    ALUSrcB= 2'b01;
    ALUOp = 2'b00;
    RegWrite = 0;
    RegDst = 0;
    end
    
    always @ (posedge clk or posedge rst)
    if(rst)
        state <= 4'b0000;
    else
        state <= nextstate;
    
    always @ (*)
    begin
    case(state)
        4'b0000:
        nextstate = 4'b0001;
        4'b0001:
        begin
        if(op[5] == 1)//lw sw
            nextstate = 4'b0010;
        else if(op == 6'b000100)//beq
            nextstate = 4'b1000;
        else if(op == 6'b000101)//bne
            nextstate = 4'b1001;
        else if(op == 6'b000010)//j
            nextstate = 4'b1010;
        else//R-type
            nextstate = 4'b0110;
        end
        4'b0010:
        begin
        if(op[3] == 0)//lw
            nextstate = 4'b0011;
        else//sw
            nextstate = 4'b0101;
        end
        4'b0011:
        nextstate = 4'b0100;
        4'b0100:
        nextstate = 4'b0000;
        4'b0101:
        nextstate = 4'b0000;
        4'b0110:
        nextstate = 4'b0111;
        4'b0111:
        nextstate = 4'b0000;
        4'b1000:
        nextstate = 4'b0000;
        4'b1001:
        nextstate = 4'b0000;
        4'b1010:
        nextstate = 4'b0000;
        default
        nextstate = 4'b0000;
    endcase
    end
    
    always @ (*)
    begin
    case(state)
        4'b0000:
        begin
        PCWriteCond = 0;
        MemRead = 1;
        IRWrite = 1;
        lorD = 0;
        PCWrite = 1;
        MemWrite = 0;
        PCSource = 2'b00;
        ALUSrcA = 0;
        ALUSrcB= 2'b01;
        ALUOp = 2'b00;
        RegWrite = 0;
        RegDst = 0;
        end
        4'b0001:
        begin
        IRWrite = 0;
        PCWrite = 0;
        ALUSrcA = 0;
        ALUSrcB= 2'b11;
        ALUOp = 2'b00;
        end
        4'b0010:
        begin
        ALUSrcA = 1;
        ALUSrcB= 2'b10;
        ALUOp = 2'b00;
        end
        4'b0011:
        begin
        MemRead = 1;
        lorD = 1;
        end
        4'b0100:
        begin
        RegDst = 0;
        RegWrite = 1;
        MemtoReg = 1;
        end
        4'b0101:
        begin
        MemRead = 0;
        MemWrite = 1;
        lorD = 1;
        end
        4'b0110:
        begin
        ALUSrcA = 1;
        ALUOp = 2'b10;
        if(op == 6'b000000)
            ALUSrcB= 2'b00;
        else//Á¢¼´ÊýÔËËã
            ALUSrcB= 2'b10;
        end
        4'b0111:
        begin
        RegWrite = 1;
        MemtoReg = 0;
        if(op == 6'b000000)
            RegDst = 1;
        else
            RegDst = 0;
        end
        4'b1000:
        begin
        ALUSrcA = 1;
        ALUSrcB= 2'b00;
        ALUOp = 2'b01;
        PCWriteCond = 1;
        PCSource = 2'b01;
        end
        4'b1001:
        begin
        ALUSrcA = 1;
        ALUSrcB= 2'b00;
        ALUOp = 2'b11;
        PCWriteCond = 1;
        PCSource = 2'b01;
        end
        4'b1010:
        begin
        PCWrite = 1;
        PCSource = 10;
        end
    endcase
    end
endmodule
