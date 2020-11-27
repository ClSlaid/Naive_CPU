`timescale 1ns/1ps
`include "../CPU/defines.sv"

module observer_tb();
    reg [2:0] mode_i;
    reg [`RegAddrBus] reg_sel_i;

    reg [`RegBus] reg_data_i;
    reg [`InstAddrBus] pc_i;
    reg [`InstBus]  ir_i;
    reg [`RegBus]   alu_a_i;
    reg [`RegBus]   alu_b_i;
    reg [`RegBus]   alu_o_i;

    reg [`RegAddrBus]  reg_sel_o;
    reg reg_read_o;
    reg [`RegBus] data_o;
    observer ob1(
        .mode_i(mode_i),
        .pc_i(pc_i),
        .reg_data_i(reg_data_i),
        .ir_i(ir_i),
        .alu_a_i(alu_a_i),
        .alu_b_i(alu_b_i),
        .alu_o_i(alu_o_i),
        .reg_sel_i(reg_sel_i),
       
        .data_o(data_o),
        .reg_sel_o(reg_sel_o),
        .reg_read_o(reg_read_o)

    );
    
    initial begin
        mode_i = 3'd0;
        pc_i = 16'h2333;
        ir_i = 16'h3222;
        alu_a_i = 16'h1000;
        alu_b_i = 16'h0100;
        alu_o_i = 16'h1100;
        reg_sel_i = 4'h0;
        reg_data_i = 16'h2000;

    end
    
    always #5 reg_sel_i = reg_sel_i + 1'b1;
    always #25 mode_i = mode_i + 1'b1;
endmodule