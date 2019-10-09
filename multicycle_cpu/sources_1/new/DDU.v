`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 21:44:41
// Design Name: 
// Module Name: DDU
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


module DDU(
    input cont,
    input step,
    input mem,
    input [7:0] addr_t,
    input [31:0] pc,
    input [31:0] mem_data,
    input [31:0] reg_data,
    input clk,
    input rst,
    output run,
    output [7:0] addr,
    output [15:0] led,
    output [7:0] an,
    output [6:0] seg
    );
    wire [31:0] data;
    assign addr = addr_t;
    assign data = mem == 0 ? mem_data : reg_data;
    assign led[15:8] = pc[7:0];
    assign led[7:0] = mem ? addr : {3'b0,addr[4:0]};
    
        
    
    SEGCTRL seg_ctrl(clk, rst, data, an, seg);
endmodule
