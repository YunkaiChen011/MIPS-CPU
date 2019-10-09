`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/07 15:37:20
// Design Name: 
// Module Name: instruction register
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


module inst_register(
    input IRWrite,
    input [31:0] inst,
    input clk,
    output [5:0] inst1,
    output [4:0] inst2,
    output [4:0] inst3,
    output [15:0] inst4
    );
endmodule
