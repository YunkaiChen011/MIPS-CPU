`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 22:03:21
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    input [31:0] pcin,
    input zeroin,
    input [31:0] aluoutin,
    input [31:0] memwdin,
    input [4:0] regwain,
    input branchin,
    input memreadin,
    input memwritein,
    input regwritein,
    input memtoregin,
    input clk,
    input rst,
    output reg [31:0] pc,
    output reg zero,
    output reg [31:0] aluout,
    output reg [31:0] memwd,
    output reg [4:0] regwa,
    output reg branch,
    output reg memread,
    output reg memwrite,
    output reg regwrite,
    output reg memtoreg
    );
    initial
    begin
        pc = 0;
        zero = 0;
        aluout = 0;
        memwd = 0;
        regwa = 0;
        branch = 0;
        memread = 0;
        memwrite = 0;
        regwrite = 0;
        memtoreg = 0;
    end
    always @ (posedge clk or posedge rst)
    if(rst)
    begin
        pc <= 0;
        zero <= 0;
        aluout <= 0;
        memwd <= 0;
        regwa <= 0;
        branch <= 0;
        memread <= 0;
        memwrite <= 0;
        regwrite <= 0;
        memtoreg <= 0;
    end
    else
    begin
        pc <= pcin;
        zero <= zeroin;
        aluout <= aluoutin;
        memwd <= memwdin;
        regwa <= regwain;
        branch <= branchin;
        memread <= memreadin;
        memwrite <= memwritein;
        regwrite <= regwritein;
        memtoreg <= memtoregin;
    end
endmodule
