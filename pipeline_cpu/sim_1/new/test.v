`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 18:02:00
// Design Name: 
// Module Name: test
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


module test(

    );
    reg [3:0] password;
    reg clk100m,clk_h,rst;
    wire ok, hs, vs;
    wire [3:0] vgar, vgag, vgab;
    wire [4:0] regadd;
    wire [3:0] regdata;
    
    top DUT(password, clk100m, clk_h, rst, ok, vgar, vgag, vgab, hs, vs, regadd, regdata);
    initial
    begin
    password = 4'b0;
    clk100m = 0;
    clk_h = 0;
    rst = 0;
    end
    always
    #5 clk100m = ~clk100m;
endmodule
