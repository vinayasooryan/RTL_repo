`timescale 1ns / 1ps

module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0];
  
  assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

  initial begin
    $readmemh("memfile.hex",mem);
  end


/*
  initial begin
 assembly instruction       machine code
addi x5, x0, 0x5              00500293
addi x6, x0, 0x3              00300313
add x7, x5, x6                006283B3

lw x8, 0x0(x0)                00002403
addi x9, x0, 0x1              00100493
add x10, x8, x9               00940533

 end
*/
endmodule