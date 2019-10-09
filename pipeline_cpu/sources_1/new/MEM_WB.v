`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 23:07:36
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input [31:0] regwd0in,
    input [31:0] regwd1in,
    input [4:0] regwain,
    input regwritein,
    input memtoregin,
    input clk,
    input rst,
    output reg [31:0] regwd0,
    output reg [31:0] regwd1,
    output reg [4:0] regwa,
    output reg regwrite,
    output reg memtoreg
    );
    initial
    begin
        regwd0 = 0;
        regwd1 = 0;
        regwa = 0;
        regwrite = 0;
        memtoreg = 0;
    end
    always @ (posedge clk or posedge rst)
    if(rst)
    begin
        regwd0 <= 0;
        regwd1 <= 0;
        regwa <= 0;
        regwrite <= 0;
        memtoreg <= 0;
    end
    else
    begin
        regwd0 <= regwd0in;
        regwd1 <= regwd1in;
        regwa <= regwain;
        regwrite <= regwritein;
        memtoreg <= memtoregin;
    end
endmodule
