
module riscv_main
    (
    input clk, reset,
    output [31:0] PC,
    input [31:0] Instr,
    output MemWrite,
    output [31:0] ALUResult, WriteData,
    input [31:0] ReadData);

    wire ALUSrc, RegWrite, Jump, Zero;
    wire [1:0] ResultSrc, ImmSrc;
    wire [2:0] ALUControl;
    wire PCSrc;
    
    wire [6:0] op;
    wire [2:0] func3;
    wire func7;
    
    assign op = Instr[6:0];
    assign func3 = Instr[14:12];
    assign func7 = Instr[30];
    
    Control_Unit c(op, func3, func7, Zero, PCSrc, ResultSrc, MemWrite, ALUControl,
        ALUSrc, ImmSrc, RegWrite, Jump);

    data_path dp(clk, reset, ResultSrc, PCSrc, ALUSrc, RegWrite, ImmSrc, ALUControl,
        ReadData, Instr, Zero, PC,  ALUResult, WriteData);
    
endmodule





 
 