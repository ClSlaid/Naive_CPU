// if_pc_tb.sv
// testbench for if_pc

/////////////////
// pc test pass!
/////////////////


`timescale 1ns / 1ps

module if_pc_tb();
reg clock;
reg reset;

reg pc_enable;

reg is_branch_taken;
reg [15:0] branch_addr;

wire [15:0] pc_addr;

initial begin
	clock = 1'b0;
	reset = 1'b1;
	pc_enable = 1'b0;
	branch_addr = 16'd8;
	is_branch_taken = 1'b0;
	#5;
	clock = 1'b1;
	#5;
	clock = 1'b0;
	#20;
	reset = 1'b0;

end

always #5 clock = ~clock;

always #20 begin
	pc_enable = 1'b1;
	#20;
	pc_enable = 1'b0;
end

always #400 begin
	is_branch_taken = 1'b1;
	#40;
	is_branch_taken = 1'b0;
end

if_pc pc0(
	.rst	(reset),
	.clk	(clock),
	
	.pc_en	(pc_enable),
	.branch_taken	(is_branch_taken),
	.branch_addr	(branch_addr),
	
	.pc_addr	(pc_addr)
);

endmodule
