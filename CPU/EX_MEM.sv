// EX_MEM.sv
// From EXecute Phase to MEMory Phase.
`timescale 1ns/1ps
`include "defines.sv"

module EX_MEM(
    input logic                 rst,        // reset
    input logic                 clk,        // clock
    input logic[`RegAddrBus]    ex_wd,      // write destination
    input logic                 ex_wreg,    // whether to write
    input logic[`RegBus]        ex_wdata,   // value to write to

    output logic[`RegAddrBus]   mem_wd,     // write destination
    output logic                mem_wreg,   // whether to write
    output logic[`RegBus]       mem_wdata  // value to write to
);

    always_ff @(posedge clk) begin: mainProc
        if (rst == `RstEnable) begin
            mem_wd <= `NOPRegAddr;
            mem_wreg <= `WriteDisable;
            mem_wdata <= `ZeroWord;
        end else begin
            mem_wd <= ex_wd;
            mem_wreg <= ex_wreg;
            mem_wdata <= ex_wdata;
        end
    end

endmodule