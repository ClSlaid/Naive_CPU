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

	 
    initial $readmemh ("inst_rom.data", inst_mem);

	 
    always_comb begin
        if(enable == `ChipDisable) begin
            inst = `ZeroWord;
        end else begin
            inst = inst_mem[addr[`InstMemNumLog2 : 1]];
        end
    end
	 
	 
endmodule