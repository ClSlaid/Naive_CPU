// observer.sv
// used to observe data
// has noting to do with main function
`timescale 1ns/1ps
`include "defines.sv"
module observer(
    input logic[`RegBus]            reg_data_i,
    input logic[`InstAddrBus]       pc_i,
    input logic[`InstBus]           ir_i,
    input logic[`RegBus]            alu_a_i,
    input logic[`RegBus]            alu_b_i,
    input logic[`RegBus]            alu_o_i,

    input logic[`RegAddrBus]        reg_sel_i,
    input logic[2:0]                sel_i,

    output logic[`RegAddrBus]       reg_sel_o,
    output logic                    reg_read_o,
    output logic[`RegBus]           data_o
);
    assign reg_sel_o = reg_sel_i;

    always_comb begin:read_reg
        if(sel_i == 3'd3) begin
            reg_read_o = 1'b1;
        end else begin
            reg_read_o = 1'b0;
        end
    end

    always_comb begin:data_select
        case(sel_i)
            3'd0: begin
                data_o = pc_i;
            end
            3'd1:begin
                data_o = ir_i;
            end
            3'd2:begin
                case(reg_sel_i)
                    8'd1:begin
                        data_o = alu_a_i;
                    end
                    8'd2:begin
                        data_o = alu_b_i;
                    end
                    default: begin
                        data_o = alu_o_i;
                    end
                endcase
            end
            3'd3:begin
                data_o = reg_data_i;
            end
            default:begin
                data_o = `ZeroWord;
            end
        endcase 
    end

endmodule