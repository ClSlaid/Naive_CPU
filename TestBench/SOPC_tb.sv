`timescale 1ns/1ps
`include "../CPU/defines.sv"
module SOPC_tb();

    logic clock_50;
    logic rst;

    initial begin
        clock_50 = 1'b0;
        forever #10 clock_50 = ~clock_50;
    end
    
    initial begin
        rst = `RstEnable;
        #195 rst = `RstDisable;
        #1000 $stop;
    end

    SOPC sopc0(
        .clk(clock_50),
        .rst(rst)
    );
endmodule