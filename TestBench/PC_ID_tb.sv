`timescale 1ns/1ps
`include "../CPU/defines.sv"
`include "../CPU/if_pc.sv"
`include "../CPU/IF_ID.sv"
`include "../CPU/id.sv"
module PC_ID_tb();
    reg rst;
    reg clk;
    wire[`InstAddrBus] pc;
    wire rom_ce_o;
    reg [`InstBus] rom_data_i;
    wire [`InstAddrBus] id_pc_i;
    wire [`InstBus] id_inst_i;

    reg[`RegBus] reg1_data;
    reg[`RegBus] reg2_data;
    
    // data forwarding...
    // data from ex phase
    reg ex_wreg_o;
    reg[`RegBus] ex_wdata_o;
    reg[`RegAddrBus] ex_wd_o;
    // data from mem phase
    reg mem_wreg_o;
    reg[`RegBus] mem_wdata_o;
    reg[`RegAddrBus] mem_wd_o;
    //
    wire reg1_read;
    wire reg2_read;
    wire[`RegAddrBus] reg1_read_addr;
    wire[`RegAddrBus] reg2_read_addr;
    
    wire[`RegBus] id_aluop_o;
    wire    id_alusel_o;

    wire[`RegBus]id_reg1_o;
    wire[`RegBus]id_reg2_o;
    wire[`RegAddrBus] id_wd_o;

    wire    id_wreg_o;
    if_pc pc0(
        .rst(rst),
        .clk(clk),
        .pc(pc),
        .ce(rom_ce_o)
    );
    IF_ID if_id0(
        .rst(rst),
        .clk(clk),
        
        .if_pc(pc),
        .if_inst(rom_data_i),

        .id_pc(id_pc_i),
        .id_inst(id_inst_i)
    );
    id id0(
        .rst(rst),
        .if_pc(id_pc_i),
        .if_inst(id_inst_i),
        
        .reg1_data_in(reg1_data),
        .reg2_data_in(reg2_data),

        .ex_wreg_f(ex_wreg_o),
        .ex_wdata_f(ex_wdata_o),
        .ex_wd_f(ex_wd_o),

        .mem_wreg_f(mem_wreg_o),
        .mem_wdata_f(mem_wdata_o),
        .mem_wd_f(mem_wd_o),

        .reg1_read(reg1_read),
        .reg2_read(reg2_read),
        .reg1_read_addr(reg1_read_addr),
        .reg2_read_addr(reg2_read_addr),

        .aluop(id_aluop_o),
        .alusel(id_alusel_o),

        .reg1_data_out(id_reg1_o),
        .reg2_data_out(id_reg2_o),
        .wd_o(id_wd_o),
        .wreg_o(id_wreg_o)
    );
    initial begin
        rst = 1'b1;
        clk = 1'b0;
        rom_data_i = 16'h3443;
        reg1_data = 16'h4;
        reg2_data = 16'h5;
        ex_wreg_o = 1'b1;
        ex_wdata_o = 16'h8;
        ex_wd_o = 4'h1;
        mem_wreg_o = 1'b1;
        mem_wdata_o = 16'd16;
        mem_wd_o = 4'd2;
        #10 rst = 1'b0;
    end
    always #5 clk = ~clk;
endmodule
