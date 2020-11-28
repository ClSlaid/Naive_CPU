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

reg [2:0] ob_mode;
reg [`InstBus] rom_data_i;
wire [`InstAddrBus] rom_addr_o;

wire rom_ce_o;
reg [`RegAddrBus] ob_sel;
wire [`RegBus] ob_data_o;

initial begin
    clk = 0;
    rst = 1;
    ob_mode = 3'b0;
    ob_sel = 4'h0;
    rom_data_i = 16'h0;
    #40 rst = 0;
end

always #5 clk = ~clk;
always rom_data_i = 16'b001101_0001_000011;
Naive_CPU nc0(
    .clk(clk),
    .rst(rst),
    .rom_data_i(rom_data_i),
    .rom_addr_o(rom_addr_o),
    .rom_ce_o(rom_ce_o),
    .ob_sel(ob_sel),
    .ob_data_o(ob_data_o),
    .ob_mode(ob_mode)
);

endmodule