`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 17:39:07
// Design Name: 
// Module Name: REG32
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


module REG32(
    input [31:0] in,
    input clk,
    input rst,
    output [31:0] out
    );
    reg [31:0] register;
    initial register = 0;
    always @ (posedge clk or posedge rst)
    if(rst)
        register = 0;
    else
        register = in;
        
    assign out = register;
endmodule
