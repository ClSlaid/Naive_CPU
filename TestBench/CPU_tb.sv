`timescale 1ns/1ps
`include "../CPU/defines.sv"
`include "../CPU/Naive_CPU.sv"
`include "../CPU/ex_alu.sv"
`include "../CPU/EX_MEM.sv"
`include "../CPU/ID_EX.sv"
`include "../CPU/id.sv"
`include "../CPU/IF_ID.sv"
`include "../CPU/if_pc.sv"
`include "../CPU/MEM_WB.sv"
`include "../CPU/mem.sv"
`include "../CPU/regfile.sv"
`include "../CPU/observer.sv"

module CPU_tb();
reg clk;
reg rst;
reg [2:0] mode;
reg [`InstBus] rom_data;
reg [`InstAddrBus] rom_addr;
reg rom_ce_o;
reg [`RegAddrBus] reg_sel;
reg [`RegBus] reg_data;
initial begin
    clk = 0;
    rst = 1;
    mode = 3'b0;
    rom_addr = 16'h0;
    reg_sel = 4'h0;
    reg_data = 16'h0;
    #40 rst = 0;
end

always #5 clk = ~clk;
always rom_data = 16'b001101_0001_000011;
Naive_CPU nc0(
    .clk(clk),
    .rst(rst),
    .rom_data_i(rom_data),
    .rom_addr_o(rom_addr_bus),
    .rom_ce_o(rom_ce_o),
    .ob_sel(reg_sel),
    .ob_data_o(reg_data),
    .ob_mode(mode)
);

endmodule