`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 20:45:50
// Design Name: 
// Module Name: MAS
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


module MAS(
    input lorD,
    input MemRead,
    input MemWrite,
    input [7:0] in1,
    input [7:0] in2,
    output reg [7:0] out1,
    output reg [7:0] out2
    );
    always @ (*)
    begin
    if(lorD == 0)
        if(MemRead == 1)
            out1 = in1;
        if(MemWrite == 1)
            out2 = in1;
    else
        if(MemRead == 1)
            out1 = in2;
        if(MemWrite == 1)
            out2 = in2;
    end
        
endmodule
