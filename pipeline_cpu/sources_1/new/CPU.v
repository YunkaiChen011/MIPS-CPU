`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 15:34:37
// Design Name: 
// Module Name: CPU
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


module CPU(
    input [4:0] regaddr_t,
    input [13:0] memaddr_t,
    input clk,
    input rst,
    output [31:0] regdata_t,
    output [31:0] memdata_t
    );
    
    wire [31:0] pcin0, pcin1, pcin, pcout;
    wire pcsrc;
    wire [7:0] instaddr;
    
    wire [31:0] pcinif;
    wire [31:0] instinif, instoutid;
    
    wire [4:0] regra0, regra1, regwa;
    wire [31:0] regrd0, regrd1, regwd, regwd0, regwd1;
    
    wire [5:0] inst31_26;
    wire [4:0] inst25_21, inst20_16, inst15_11;
    wire [15:0] inst15_0;
    
    wire [5:0] op;
    wire regdstinid, alusrcinid, branchinid, memreadinid, memwriteinid, regwriteinid, memtoreginid;
    wire [1:0] aluopinid;
    
    wire [31:0] pcinid, pcoutex;
    wire [31:0] instexinid, instexoutex;
    
    wire [4:0] inst0outex, inst1outex;
    wire regdst, alusrc, branchinex, memreadinex, memwriteinex, regwriteinex, memtoreginex;
    wire [1:0] aluop;
    
    wire [31:0] aluin0, aluin1, aluin10, aluin11;
    wire [31:0] aluout;
    wire [2:0] alusel;
    wire zero;
    
    wire [5:0] alucin;
    
    wire [4:0] regwainex;
    wire [31:0] pcinex, pcinexadd;
    wire [31:0] memwdinex;
    wire zeroout;
    wire branch, memread, memwrite;
    wire regwriteinmem, memtoreginmem;
    wire [31:0] memwd;
    
    wire [31:0] regwd0inmem, regwd1inmem;
    wire [4:0] regwainmem;
    
    wire [13:0] memaddr;
    wire memwe;
    
    wire regwrite, memtoreg;
    
    
    assign pcin0 = pcout + 32'b100;
    assign pcin = pcsrc ? pcin1 :pcin0;
    assign instaddr = pcout[9:2];
    
    assign pcinif = pcin0;
    
    assign inst31_26 = instoutid[31:26];
    assign inst25_21 = instoutid[25:21];
    assign inst20_16 = instoutid[20:16];
    assign inst15_11 = instoutid[15:11];
    assign inst15_0 = instoutid[15:0];
    assign regra0 = inst25_21;
    assign regra1 = inst20_16;
    assign op = inst31_26;
    
    //指令15-0符号扩展
    assign instexinid = inst15_0[15] ? {16'b1111_1111_1111_1111, inst15_0} : {16'b0000_0000_0000_0000, inst15_0};
    
    //ALU输入
    assign aluin1 = alusrc ? aluin11 : aluin10;
    assign aluin11 = instexoutex;
    
    assign alucin = instexoutex[5:0];
    
    assign pcinexadd = {instexoutex[29:0], 2'b00};//15-0扩展后左移两位
    assign pcinex = pcoutex + pcinexadd;
    assign regwainex = regdst ? inst1outex : inst0outex;
    assign memwdinex = aluin10;
    
    assign memaddr = regwd1inmem[15:2];
    assign memwe = memwrite & (~memread);
    
    assign pcsrc = branch & zeroout;
    
    assign regwd = memtoreg ? regwd1 : regwd0;
    
    
    
    dist_mem_gen_0 INSTMEM(
    .a(instaddr),
    .spo(instinif)
    );
    dist_mem_gen_1 DATAMEM(
    .a(memaddr),
    .d(memwd),
    .dpra(memaddr_t),
    .clk(clk),
    .we(memwe),
    .spo(regwd0inmem),
    .dpo(memdata_t)
    );
    
    
    PC PC_s(pcin, clk, rst, pcout);
    
    IF_ID IFID(pcinif, instinif, clk, rst, pcinid, instoutid);
    
    REG REG_f(regaddr_t, regra0, regra1, regwa, regwd, regwrite, rst, clk, regdata_t, regrd0, regrd1);
    
    CTRL CONTROL(op, clk, rst, regdstinid, aluopinid, alusrcinid,
    branchinid, memreadinid, memwriteinid, regwriteinid, memtoreginid);
    
    ID_EX IDEX(pcinid, regrd0, regrd1, instexinid, inst20_16, inst15_11, regdstinid, aluopinid,
    alusrcinid,branchinid, memreadinid, memwriteinid, regwriteinid, memtoreginid, clk, rst, pcoutex,
    aluin0, aluin10, instexoutex, inst0outex, inst1outex, regdst, aluop, alusrc, branchinex, memreadinex,
    memwriteinex, regwriteinex, memtoreginex);
    
    ALU ALU_s(aluin0, aluin1, alusel, zero, aluout);
    
    ALUC ALU_CTRL(alucin, aluop, alusel);
    
    EX_MEM EXMEM(pcinex, zero, aluout, memwdinex, regwainex, branchinex, memreadinex, memwriteinex,
    regwriteinex, memtoreginex, clk, rst, pcin1, zeroout, regwd1inmem, memwd, regwainmem, branch, memread,
    memwrite, regwriteinmem, memtoreginmem);
    
    MEM_WB MEMWB(regwd0inmem, regwd1inmem, regwainmem, regwriteinmem, memtoreginmem, clk, rst,
    regwd0, regwd1, regwa, regwrite, memtoreg);
endmodule
