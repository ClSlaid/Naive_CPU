// regfile_tb.sv
// testbentch for regfile
`include "../cpu/defines.sv"
`timescale 1ns/1ps

module regfile_tb();
reg clock;
reg reset;

reg we;
reg [`RegAddrBus]waddr;
reg [`RegBus] wdata;

reg rse;
reg [`RegAddrBus]rsaddr;
reg [`RegBus]rsdata;

regfile r1(
    .clk(clock),
    .rst(reset),

    .we(we),
    .waddr(waddr),
    .wdata(wdata),

    .rse(rse),
    .rsaddr(rsaddr),
    .rsdata(rsdata)
);

initial begin
    wdata = 16'h0;
    clock = 1'b0;
    reset = 1'b1;
    rsaddr = 4'h0;
    waddr = 4'h1;

    #40 reset = 1'b0;
end

always #5 clock = ~clock;
//always #1600 begin
//    reset = 1;
//    #20;
//    reset = 0;
//end
always #400 begin
    we = 1'b1;
    #20;
    waddr = waddr + 1'b1;
    we = 1'b0;
end

always #800 begin
    wdata = wdata + 1'b1;
end

always #50 begin
    rse = 1'b1;
    rsaddr = rsaddr + 1'b1;
end

endmodule