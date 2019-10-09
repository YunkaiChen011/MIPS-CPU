`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 16:08:40
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input [31:0] pcin,
    input [31:0] instin,
    input clk,
    input rst,
    output reg [31:0] pc,
    output reg [31:0] inst
    );
    initial inst = 0;
    initial pc = 0;
    always @ (posedge clk or posedge rst)
    if(rst)
    begin
        inst <= 0;
        pc <= 0;
    end
    else
    begin
        inst <= instin;
        pc <= pcin;
    end
    
endmodule
