`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 16:37:51
// Design Name: 
// Module Name: REG
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


module REG(
    input [4:0] ratest,
    input [4:0] ra0,
    input [4:0] ra1,
    input [4:0] wa,
    input [31:0] wd,
    input we,
    input rst,
    input clk,
    output [31:0] rdtest,
    output [31:0] rd0,
    output [31:0] rd1
    );
    reg [31:0] register [0:31];
    integer i;
    initial
    begin
    for(i = 0; i< 32; i = i + 1)
        register[i] = 0;
    end
    always @ (posedge clk or posedge rst)
    if(rst)
    begin
    for(i = 0; i< 32; i = i + 1)
        register[i] <= 0;
    end
    else if(we == 1)
        if(wa != 0)
            register[wa] <= wd;
        
    assign rd0 = register[ra0];
    assign rd1 = register[ra1];
    assign rdtest = register[ratest];
endmodule
