`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/17 14:40:14
// Design Name: 
// Module Name: CLKC
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


module CLKC(
    input clk100m,
    input cont,
    input step,
    input rst,
    output clk
    );
    wire clk5m;
    wire clk1;
    
    reg [22:0] cnt;
    
    clk_wiz_0 clk_low(
    .reset(rst),
    .clk_in1(clk100m),
    .clk_out1(clk5m)
    );
    
    always @ (posedge clk5m or posedge rst)
    if(rst)
        cnt <= 0;
    else
        if(cnt < 23'd5000000)
            cnt <= cnt + 1;
        else cnt <= 0;
        
    assign clk1 = cnt < 23'd2500000 ? 0 : 1;
    assign clk = cont == 1 ? clk1 : step;
endmodule
