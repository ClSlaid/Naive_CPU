`timescale 1ns/1ps

`include "../SOPC/SOPC.sv"

module SOPC_tb();

    logic clock_50;
    logic rst;

    initial begin
        clock_50 = 1'b0;
        rst = `RstEnable;
        #190 rst = `RstDisable;
    end

    always #10 clock_50 = ~clock_50;
    SOPC sopc0(
        .clk(clock_50),
        .rst(rst)
    );
endmodule