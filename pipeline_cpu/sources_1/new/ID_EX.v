`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 20:17:13
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input [31:0] pcin,
    input [31:0] regd0in,
    input [31:0] regd1in,
    input [31:0] instexin,
    input [4:0] inst0in,
    input [4:0] inst1in,
    input regdstin,
    input [1:0] aluopin,
    input alusrcin,
    input branchin,
    input memreadin,
    input memwritein,
    input regwritein,
    input memtoregin,
    input clk,
    input rst,
    output reg [31:0] pc,
    output reg [31:0] regd0,
    output reg [31:0] regd1,
    output reg [31:0] instex,
    output reg [4:0] inst0,
    output reg [4:0] inst1,
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
        pc = 0;
        regd0 = 0;
        regd1 = 0;
        instex = 0;
        inst0 = 0;
        inst1 = 0;
        regdst = 0;
        aluop = 0;
        alusrc = 0;
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
        regd0 <= 0;
        regd1 <= 0;
        instex <= 0;
        inst0 <= 0;
        inst1 <= 0;
        regdst <= 0;
        aluop <= 0;
        alusrc <= 0;
        branch <= 0;
        memread <= 0;
        memwrite <= 0;
        regwrite <= 0;
        memtoreg <= 0;
    end
    else
    begin
        pc <= pcin;
        regd0 <= regd0in;
        regd1 <= regd1in;
        instex <= instexin;
        inst0 <= inst0in;
        inst1 <= inst1in;
        regdst <= regdstin;
        aluop <= aluopin;
        alusrc <= alusrcin;
        branch <= branchin;
        memread <= memreadin;
        memwrite <= memwritein;
        regwrite <= regwritein;
        memtoreg <= memtoregin;
    end
endmodule
