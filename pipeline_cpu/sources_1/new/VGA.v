`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 15:27:54
// Design Name: 
// Module Name: VGA
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


module VGA(
    input [11:0] vdata,
    input clk,
    input rst,
    output wire [15:0] vaddr,
    output reg [3:0] vgar,
    output reg [3:0] vgag,
    output reg [3:0] vgab,
    output hs,
    output vs
    );
    
        parameter HS_S = 56;
        parameter HS_E = 56 + 120;
        parameter HA_S = 56 + 120 + 64;
        parameter VS_S = 600 + 37;
        parameter VS_E = 600 + 37 + 6;
        parameter VA_E = 600;
        parameter LINE = 1040;
        parameter SCREEN = 666;
        parameter UP = 236;
        parameter DOWN = 365;
        parameter LEFT = 336;
        parameter RIGHT = 465;
        
        reg [10:0] h_count;
        reg [9:0] v_count;
        wire [9:0] ox;
        wire [9:0] oy;
        wire [6:0] px;
        wire [6:0] py;
        
        assign hs = ~((h_count >= HS_S) & (h_count < HS_E));
        assign vs = ~((v_count >= VS_S) & (v_count < VS_E));
        
        assign ox = (h_count < HA_S) ? 0 : (h_count - HA_S);
        assign oy = (v_count >= VA_E) ? (VA_E - 1) : (v_count);
        
        assign px = ((ox > LEFT) && (ox < RIGHT)) ? (ox - LEFT - 1) : ((ox <= LEFT) ? 0 : 127);
        assign py = ((oy > UP) && (oy < DOWN)) ? (oy - UP - 1) : ((oy <= UP) ? 0 : 127);
        assign vaddr = {py,px};
        
        always @ (posedge clk or posedge rst)
        if(rst)
        begin
            h_count <= 0;
            v_count <= 0;
        end
        else
        begin
            if(h_count == LINE)
            begin
                h_count <= 0;
                v_count <= v_count + 1;
            end
            else
                h_count <= h_count + 1;
            if(v_count == SCREEN)
                v_count <= 0;
        end    
        
        always @ (ox or oy)
        begin
        if((ox > LEFT) && (ox < RIGHT) && (oy > UP) && (oy < DOWN))
        begin
            if(vdata == 12'b0)
                {vgar,vgag,vgab} = 12'b1111_1111_1111;
            else
                {vgar,vgag,vgab} = vdata;
        end
        else
            {vgar,vgag,vgab} = 12'b0;
        end
endmodule
