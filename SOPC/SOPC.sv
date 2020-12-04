// SOPC.sv
// Minimal SOPC
`timescale 1ns/1ps
`include "../CPU/defines.sv"
`include "../CPU/Naive_CPU.sv"
`include "../ROM/ROM.sv"

module SOPC(
    input               rst,    // rst
    input               clk     // clock 
);
    wire[`InstAddrBus]  inst_addr;
    wire[`InstBus]      inst;
    wire                rom_ce;

    Naive_CPU cpu0(
        .clk(clk),
        .rst(rst),
        .rom_addr_o(inst_addr),
        .rom_data_i(inst),
        .rom_ce_o(rom_ce)
    );

    ROM rom0(
        .enable(rom_ce),
        .addr(inst_addr),
        .inst(inst)
    );
endmodule