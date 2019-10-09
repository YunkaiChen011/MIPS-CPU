`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:21:13
// Design Name: 
// Module Name: PC
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


module PC(
    input [31:0] in,
    input clk,
    input rst,
    output [31:0] out
    );
    reg [31:0] pc;
    initial pc = 0;
    assign out = pc;
    always @ (posedge clk or posedge rst)
    if(rst)
        pc <= 0;
    else
        pc <= in;
endmodule
