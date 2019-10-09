`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 23:36:24
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
    reg cont, step, mem, clk100m, rst;
    reg [7:0] addr_t;
    wire [15:0] led;
    wire [7:0] an;
    wire [6:0] seg;
    top DUT(cont, step, mem, addr_t, clk100m, rst, led, an, seg);
    initial
    begin
    cont = 0;
    step = 0;
    mem = 0;
    addr_t = 8'b0000_0010;
    clk100m = 0;
    rst = 0;
    end
    always
    #5 clk100m = ~clk100m;
endmodule
