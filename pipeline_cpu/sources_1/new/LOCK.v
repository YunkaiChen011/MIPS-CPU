`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 02:33:23
// Design Name: 
// Module Name: LOCK
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


module LOCK(
    input [3:0] password,
    input [31:0] regdata_t,
    input clk,
    input rst,
    output reg [4:0] regaddr_t,
    output ok
    );
    wire [3:0] regdata;
    reg [2:0] state, nextstate;
    
    assign regdata = regdata_t[3:0];
    assign ok = state == 3'b100 ? 1 : 0;
    
    initial
    begin
    state = 0;
    nextstate = 0;
    end
    always @ (posedge clk or posedge rst)
    if(rst)
        state <= 0;
    else
        state <= nextstate;
    
    always @ (*)
    begin
    case(state)
        3'b000:
        if(password == regdata)
            nextstate = 3'b001;
        else
            nextstate = 0;
        3'b001:
        if(password == regdata)
            nextstate = 3'b010;
        else
            nextstate = 0;
        3'b010:
        if(password == regdata)
            nextstate = 3'b011;
        else
            nextstate = 0;
        3'b011:
        if(password == regdata)
            nextstate = 3'b100;
        else
            nextstate = 0;
        3'b100:
            nextstate = 3'b100;
        default:
            nextstate = 0;
    endcase
    end
    
    always @ (*)
    begin
    case(state)
        3'b000:regaddr_t = 5'b01000;
        3'b001:regaddr_t = 5'b01001;
        3'b010:regaddr_t = 5'b01010;
        3'b011:regaddr_t = 5'b01011;
        3'b100:regaddr_t = 5'b01000;
    endcase
    end
endmodule
