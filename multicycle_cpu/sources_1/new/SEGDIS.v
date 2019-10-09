`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 00:05:29
// Design Name: 
// Module Name: SEGDIS
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


module SEGDIS(
    input [3:0] data,
    input [7:0] sel,
    output [7:0] an,
    output reg [6:0] seg
    );
    assign an = sel;
    always @ (data)
        begin
        case(data)
        4'b0000: seg = 7'b1000_000;
        4'b0001: seg = 7'b1111_001;
        4'b0010: seg = 7'b0100_100;
        4'b0011: seg = 7'b0110_000;
        4'b0100: seg = 7'b0011_001;
        4'b0101: seg = 7'b0010_010;
        4'b0110: seg = 7'b0000_010;
        4'b0111: seg = 7'b1111_000;
        4'b1000: seg = 7'b0000_000;
        4'b1001: seg = 7'b0010_000;
        4'b1010: seg = 7'b0001_000;//A
        4'b1011: seg = 7'b0000_011;//b
        4'b1100: seg = 7'b1000_110;//C
        4'b1101: seg = 7'b0100_001;//d
        4'b1110: seg = 7'b0000_110;//E
        4'b1111: seg = 7'b0001_110;//F
        endcase
        end
endmodule
