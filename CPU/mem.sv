// mem.sv
// operation in MEMory Phase
`timescale 1ns/1ps
`include "defines.sv"
module mem(
    input logic                 rst,        // reset

    input logic[`RegAddrBus]    wd_i,       // write destination    (input)
    input logic                 wreg_i,     // whether to write to  (input)
    input logic[`RegBus]        wdata_i,    // write data           (input)
    
    output logic[`RegAddrBus]   wd_o,       // write destination    (output)
    output logic                wreg_o,     // whether to write to  (output)
    output logic[`RegBus]       wdata_o     // write data           (output)
);
    
    always_comb begin: pass
        if(rst == `RstEnable) begin
            wd_o = `NOPRegAddr;
            wreg_o = `WriteDisable;
            wdata_o = `ZeroWord;
        end else begin
            wd_o = wd_i;
            wreg_o = wreg_i;
            wdata_o = wdata_i;
        end
    end

endmodule
