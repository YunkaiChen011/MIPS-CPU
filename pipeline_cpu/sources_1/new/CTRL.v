`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 18:07:11
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
    output reg regdst,
    output reg [1:0] aluop,
    output reg alusrc,
    output reg branch,
    output reg memread,
    output reg memwrite,
    output reg regwrite,
    output reg memtoreg
    );
    initial
    begin
    regdst = 0;
    aluop = 0;
    alusrc = 0;
    branch = 0;
    memread = 0;
    memwrite = 0;
    regwrite = 0;
    memtoreg = 0;
    end
    always @ (*)
    if(rst)
    begin
        regdst = 0;
        aluop = 0;
        alusrc = 0;
        branch = 0;
        memread = 0;
        memwrite = 0;
        regwrite = 0;
        memtoreg = 0;
    end
    else
    begin
        if(op == 6'b0)//R-type
        begin
            regdst = 1;
            aluop = 2'b10;
            alusrc = 0;
            branch = 0;
            memread = 0;
            memwrite = 0;
            regwrite = 1;
            memtoreg = 1;
        end
        else if(op == 6'b100011)//lw
        begin
            regdst = 0;
            aluop = 2'b0;
            alusrc = 1;
            branch = 0;
            memread = 1;
            memwrite = 0;
            regwrite = 1;
            memtoreg = 0;
        end
        else if(op == 6'b101011)//sw
        begin
            regdst = 0;
            aluop = 2'b0;
            alusrc = 1;
            branch = 0;
            memread = 0;
            memwrite = 1;
            regwrite = 0;
            memtoreg = 0;    
        end
        else if(op == 6'b000101)//bne
        begin
            regdst = 0;
            aluop = 2'b01;
            alusrc = 0;
            branch = 1;
            memread = 0;
            memwrite = 0;
            regwrite = 0;
            memtoreg = 0;
        end
        else if(op == 6'b001000)//addi
        begin
            regdst = 0;
            aluop = 2'b11;
            alusrc = 1;
            branch = 0;
            memread = 0;
            memwrite = 0;
            regwrite = 1;
            memtoreg = 1;
        end
    end
endmodule
