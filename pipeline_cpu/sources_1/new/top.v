`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:20:33
// Design Name: 
// Module Name: top
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


module top(
    //input [3:0] password,
    input clk100m,
    //input clk_h,
    input rst,
    //output ok,
    //output [3:0] vgar,
    //output [3:0] vgag,
    //output [3:0] vgab,
    //output hs,
    //output vs,
    output [4:0] regadd,
    output [7:0] regdata
    );
    reg [26:0] cnt;
    reg [4:0] regaddr_t = 5'b01010;
    wire [13:0] memaddr_t;
    wire [31:0] regdata_t, memdata_t;
    wire clk50m;
    //wire [11:0] vdata;
    //wire [15:0] vaddr;
    wire clk1;
    
    //assign vdata = ok ? memdata_t[11:0] : 12'b1111_1111_1111;
    //assign memaddr_t = vaddr[13:0];
    assign regadd = regaddr_t;
    assign regdata = regdata_t[7:0];
    
    clk_wiz_0 inst(
        .clk_in1(clk100m),
        .clk_out1(clk50m)
        );
    
    CPU PIPELINE(regaddr_t, memaddr_t, clk1, rst, regdata_t, memdata_t);
    //LOCK LOCK_s(password, regdata_t, clk_h, rst, regaddr_t, ok);
    //VGA DDU(vdata, clk50m, rst, vaddr, vgar, vgag, vgab, hs, vs);
    
    always @ (posedge clk50m or posedge rst)
    if(rst)
        cnt <= 0;
    else
        if(cnt < 27'd50000000)
            cnt <= cnt + 1;
        else cnt <= 0;
        
    assign clk1 = cnt < 27'd25000000 ? 0 : 1;

endmodule
