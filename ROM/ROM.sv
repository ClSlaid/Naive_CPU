// ROM.sv
// Read Only Memory
`timescale 1ns/1ps
`include "../CPU/defines.sv"

module ROM(
    input               enable,        // reset
    input[15:0]         addr,       // address
    output logic[15:0]  inst       // instrution
);

    logic[`InstBus] inst_mem[0:`InstMemNum - 1];
    
	 
    initial begin
        inst_mem[0] = 16'h3343;
        inst_mem[1] = 16'h0000;
        inst_mem[2] = 16'h3344;
        inst_mem[3] = 16'h3048;
        inst_mem[4] = 16'h0843;
        inst_mem[5] = 16'h0c43;
    end

	 
    always_comb begin
        if(enable == `ChipDisable) begin
            inst = `ZeroWord;
        end else begin
            inst = inst_mem[addr];
        end
    end
	 
	 
endmodule