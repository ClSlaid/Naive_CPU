// MEM_WB.sv
// MEMory Phase to Write Back Phase
`timescale 1ns/1ps
`include "defines.sv"

module MEM_WB(
    input logic                 rst,        // reset
    input logic                 clk,        // clock

    input logic[`RegAddrBus]    mem_wd,     // write destination
    input logic                 mem_wreg,   // whether to write to
    input logic[`RegBus]        mem_wdata,  // data to write to

    output logic[`RegAddrBus]   wb_wd,      // write destination
    output logic                wb_wreg,    // whether to write to
    output logic[`RegBus]       wb_wdata   // data to write to
);
    always_ff @(posedge clk) begin
        if(rst == `RstEnable) begin
            wb_wd <= `NOPRegAddr;
            wb_wreg <= `WriteDisable;
            wb_wdata <= `ZeroWord;
        end else begin
            wb_wd <= mem_wd;
            wb_wreg <= mem_wreg;
            wb_wdata <= mem_wdata;
        end
    end
    
endmodule