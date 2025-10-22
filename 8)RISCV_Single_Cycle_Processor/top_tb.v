`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2025 17:41:48
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb(

    input   clk, reset,
    output  [31:0] WriteData, DataAdr,
    output  MemWrite);
    
    wire [31:0] PC, Instr, ReadData;
    // instantiate processor and memories
    riscv_main rvsingle(clk, reset, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);
    
    imem_tb imem(PC, Instr);
    
    dmem_tb dmem(.clk(clk), .WE(MemWrite), .A(DataAdr), .WD(WriteData), .RD(ReadData));

endmodule