`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 23:13:44
// Design Name: 
// Module Name: MUX2_8
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


module MUX2_8(
    input [7:0] in1,
    input [7:0] in2,
    input ctrl,
    input [7:0] out
    );
    assign out = ctrl ? in2 : in1;
endmodule
