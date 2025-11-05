`timescale 1ns / 1ps
//`include "Mux.v"

module writeback_cycle(clk,rst,ResultSrcW,PCPlus4W,ALU_ResultW,ReadDataW,ResultW);

//declaration of I/Os
input clk, rst, ResultSrcW;
input [31:0]PCPlus4W,ALU_ResultW,ReadDataW;

output [31:0]ResultW;

//declaration of module

Mux result_mux (
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                );

   
endmodule
