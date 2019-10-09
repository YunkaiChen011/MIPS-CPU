`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/07 15:39:21
// Design Name: 
// Module Name: IR
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


module IR(
    input IRWrite,
    input clk,
    input [31:0] inst,
    output [5:0] inst1,
    output [4:0] inst2,
    output [4:0] inst3,
    output [15:0] inst4
    );
    reg [31:0] instruction;
    assign inst1 = instruction[31:26];
    assign inst2 = instruction[25:21];
    assign inst3 = instruction[20:16];
    assign inst4 = instruction[15:0];
    always @ (posedge clk)
    if(IRWrite)
    instruction <= inst;
endmodule
