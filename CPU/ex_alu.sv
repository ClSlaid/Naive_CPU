// ex_alu.sv
// ALU and its support
`timescale 1ns/1ps
`include "defines.sv"

module ex_alu(
    input logic                 rst,        // reset
    input logic[`AluOpBus]      aluop_i,    // ALU Operation Type
    input logic[`AluSelBus]      alusel_i,   // ALU Operation Class
    input logic[`RegBus]        reg1_i,     // register 1 input
    input logic[`RegBus]        reg2_i,     // register 2 input
    input logic[`RegAddrBus]    wd_i,       // register address to write in
    input logic                 wreg_i,     // whether to write in logic bus
    
    output logic[`RegAddrBus]   wd_o,       // address to write to
    output logic                wreg_o,     // whether to write to
    output logic[`RegBus]       wdata_o     // calculate outcome
);
    logic[`RegBus]  logicout;
    
    // ALU Main
    always_comb begin: ALU
        if(rst == `RstEnable) begin
            logicout = `ZeroWord;
        end else begin
            case (aluop_i)
                `EXE_OR_OP: begin
                    logicout = reg1_i | reg2_i;
                end
                default: begin
                    logicout = `ZeroWord;
                end
            endcase
        end // End Else
    end

    always_comb begin: outcome
        wd_o = wd_i;
        wreg_o = wreg_i;

        case(alusel_i)
            `EXE_RES_LOGIC:begin
                wdata_o = logicout;
            end
            default: begin
                wdata_o = `ZeroWord;
            end
        endcase
    end

endmodule
