`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 23:52:39
// Design Name: 
// Module Name: SEGCTRL
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


module SEGCTRL(
    input clk,
    input rst,
    input [31:0] data,
    output [7:0] an,
    output [6:0] seg
    );
    reg [20:0] cnt;
    reg [7:0] sel;
    reg [3:0] data16;
    
    always @ (posedge clk or posedge rst)
    if(rst)
        cnt <= 21'b0;
    else if(cnt < 21'd1000000)
        cnt <= cnt + 1;
    else
        cnt <= 21'b0;
    
    always @ (posedge clk or posedge rst)
    begin
        if(rst)
            sel <= 8'b0;
        else
            case(cnt[18:16])
            3'b000:
            begin
            sel <= 8'b0111_1111;
            data16 <= data[31:28];
            end
            3'b001:
            begin
            sel <= 8'b1011_1111;
            data16 <= data[27:24];
            end
            3'b010:
            begin
            sel <= 8'b1101_1111;
            data16 <= data[23:20];
            end
            3'b011:
            begin
            sel <= 8'b1110_1111;
            data16 <= data[19:16];
            end
            3'b100:
            begin
            sel <= 8'b1111_0111;
            data16 <= data[15:12];
            end
            3'b101:
            begin
            sel <= 8'b1111_1011;
            data16 <= data[11:8];
            end
            3'b110:
            begin
            sel <= 8'b1111_1101;
            data16 <= data[7:4];
            end
            3'b111:
            begin
            sel <= 8'b1111_1110;
            data16 <= data[3:0];
            end
            endcase
    end
    
    SEGDIS seg_display(data16, sel, an, seg);
endmodule
