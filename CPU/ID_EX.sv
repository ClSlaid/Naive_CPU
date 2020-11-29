// ID_EX.sv
// EXecute phase
`timescale 1ns/1ps
`include "defines.sv"

module ID_EX(
    input logic                    rst,        // reset
    input logic                    clk,        // clock

    input logic [`AluOpBus]        id_aluop,  // ALU Instruction Class, recieved from ID phase
    input logic [`AluSelBus]       id_alusel,   // ALU Instruction Type, recieved from ID phase

    input logic [`RegBus]          id_reg1,    // reg1, recieved from ID phase
    input logic [`RegBus]           id_reg2,    // reg2, recieved from ID phase
    
    input logic [`RegAddrBus]       id_wd,      // Register to write in, recieved from ID phase
    input logic                     id_wreg,    // Whether to write in, recieved from ID phase

    output logic [`AluOpBus]        ex_aluop,   // ALU Instrution Class, Pass to EX phase
    output logic [`AluSelBus]       ex_alusel,  // ALU Instrution Type, Pass to EX phase

    output logic [`RegBus]          ex_reg1,    // reg1, Pass to EX phase
    output logic [`RegBus]          ex_reg2,    // reg2, Pass to EX phase

    output logic [`RegAddrBus]      ex_wd,      // Register to write in, Pass to EX phase
    output logic                    ex_wreg    // Whether to write in, Pass to EX phase
);

    always_ff @(posedge clk) begin: MainProc
        if(rst == `RstEnable) begin
            ex_aluop <= `EXE_NOP_OP;
            ex_alusel <= `EXE_RES_NOP;
            ex_reg1 <= `ZeroWord;
            ex_reg2 <= `ZeroWord;
            ex_wd <= 4'b0;
            ex_wreg <= `WriteDisable;
        end else begin
            ex_aluop <= id_aluop;
            ex_alusel <= id_alusel;
            ex_reg1 <= id_reg1;
            ex_reg2 <= id_reg2;
            ex_wd <= id_wd;
            ex_wreg <= id_wreg;
        end
    end

endmodule