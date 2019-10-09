`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 21:30:40
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
    input cont,
    input step,
    input mem,
    input [7:0] addr_t,
    input clk100m,
    input rst,
    output [15:0] led,
    output [7:0] an,
    output [6:0] seg
    );
    
    wire clk;
    //CPU
    wire memwrite;
    wire memread;
    wire [7:0] memadd;
    wire [31:0] mwritedata;
    wire memwe;
    wire [31:0] inst;
    
    wire [1:0] pcsource;
    wire [31:0] pcin, pcout, pcin0, pcin1, pcin2;
    wire [3:0] pcin21;
    wire [4:0] pcin22, pcin23;
    wire [15:0] pcin24;
    wire pcen;
    wire pcwrite;
    wire [7:0] memadd0, memadd1;
    wire lord;
    
    wire irwrite;
    wire [5:0] inst1;
    wire [4:0] inst2, inst3;
    wire [15:0] inst4;
    
    wire regwrite, regdst;
    wire [31:0] rwritedata, rwritedata0, rwritedata1;
    wire [4:0] regadd, regadd0, regadd1;
    wire [31:0] rd0, rd1;
    
    wire alusrca;
    wire [1:0] alusrcb;
    wire [31:0] alu10, alu11;
    wire [31:0] alu20, alu21, alu22, alu23;
    wire [31:0] alu1, alu2;
    wire [2:0] aluctrl;
    wire [31:0] aluoutin, aluout;
    wire zero;
    
    wire [31:0] mdrin;
    wire memtoreg;
    
    wire [5:0] alucin1, alucin2;
    wire [1:0] aluop;
    
    wire [5:0] op;
    wire pcwritecond;
    
    //DDU
    wire [7:0] addr;
    wire [7:0] memadd_t;
    wire [4:0] regadd_t;
    wire [31:0] mem_data;
    wire [31:0] reg_data;
    wire [31:0] pc;
    wire run;
    
    //CPU
    assign pcin = pcsource[1] ? pcin2 : (pcsource[0] ? pcin1 : pcin0);//pc输入多选器
    assign pcin0 = aluoutin;
    assign pcin1 = aluout;
    assign pcin21 = pcout[31:28];
    assign pcin22 = inst2;
    assign pcin23 = inst3;
    assign pcin24 = inst4;
    assign pcin2 = {pcin21,pcin22,pcin23,pcin24,2'b00};
    
    assign memwe = memwrite && (~memread);
    assign mwritedata = alu20;
    assign memadd = lord ? memadd1 : memadd0;//存储器读写地址多选器
    assign memadd0 = pcout[9:2];
    assign memadd1 = aluout[9:2];
    
    assign regadd = regdst ? regadd1 : regadd0;//寄存器堆写地址多选器
    assign regadd0 = inst3;
    assign regadd1 = inst4[15:11];
    
    assign rwritedata = memtoreg ? rwritedata1 : rwritedata0;//寄存器堆写数据多选器
    assign rwritedata0 = aluout;
    
    assign mdrin = inst;
    
    assign alu1 = alusrca ? alu11 : alu10;//ALU操作数1多选器
    assign alu10 = pcout;
    assign alu2 = alusrcb[1] ? (alusrcb[0] ? alu23 : alu22) : (alusrcb[0] ? alu21 : alu20);//ALU操作数2多选器
    assign alu21 = 31'd4;
    assign alu22 = inst4[15] == 1 ? {16'b1111_1111_1111_1111,inst4} : {16'b0,inst4};//sign extend
    assign alu23 = {alu22[29:0],2'b00};//shift left 2
    
    assign alucin1 = inst1;
    assign alucin2 = inst4[5:0];
    
    assign op = inst1;
    assign pcen = (zero & pcwritecond) | pcwrite;
    
    //DDU
    assign memadd_t = addr;
    assign regadd_t = addr[4:0];
    assign pc = pcout;
    
    dist_mem_gen_0 MEM(
    .a(memadd),
    .d(mwritedata),
    .we(memwe),
    .clk(clk),
    .spo(inst),
    .dpra(memadd_t),
    .dpo(mem_data)
    );
    
    PC PC_s(pcin, pcen, clk, rst, pcout);
    IR IR_s(irwrite, clk, inst, inst1, inst2, inst3, inst4);
    REG REG_s(regadd_t, inst2, inst3, regadd, rwritedata, regwrite, rst, clk, reg_data, rd0, rd1);
    REG32 REG32_A(rd0, clk, rst, alu11);
    REG32 REG32_B(rd1, clk, rst, alu20);
    REG32 MDR(mdrin, clk, rst, rwritedata1);
    REG32 ALUOut(aluoutin, clk, rst, aluout);
    ALU ALU_s(alu1 ,alu2, aluctrl, zero, aluoutin);
    ALUC ALUC_s(alucin1, alucin2, aluop, aluctrl);
    CTRL CONTROL(op, clk, rst, pcwritecond, pcwrite, lord, memread, memwrite, memtoreg, irwrite, pcsource,aluop, alusrca, alusrcb, regwrite, regdst);
    
    
    DDU DDU_s(cont, step, mem, addr_t, pc, mem_data, reg_data, clk100m, rst, run, addr, led, an, seg);
    CLKC CLK_CTRL(clk100m, cont, step, rst, clk);
endmodule
