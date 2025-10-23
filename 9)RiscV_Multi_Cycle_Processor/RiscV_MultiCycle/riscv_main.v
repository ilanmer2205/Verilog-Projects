
module riscv_main
    (
    input clk, reset,
    input [31:0] ReadData,
    output [31:0] Adr,
    output MemWrite,
    output [31:0] WriteData);
    

    wire RegWrite, Zero;
    wire [1:0] ResultSrc, ImmSrc;
    wire [2:0] ALUControl;
    
    wire [6:0] op;
    wire [2:0] func3;
    wire func7;
    
    wire PCWrite;
    wire AdrSrc;
    wire IRWrite;
    wire [1:0] ALUSrcA, ALUSrcB; 

    wire [31:0] Instr;
    
    assign op = Instr[6:0];
    assign func3 = Instr[14:12];
    assign func7 = Instr[30];
    
    Control_Unit c(clk, reset, op, func3, func7, Zero, PCWrite, AdrSrc, MemWrite,
                    IRWrite, ResultSrc, ALUControl, ALUSrcA, ALUSrcB, ImmSrc, RegWrite);

    data_path dp(clk, reset, ReadData, PCWrite, AdrSrc, IRWrite, ResultSrc,
                  ALUControl, ALUSrcA, ALUSrcB, ImmSrc, RegWrite, Zero, Adr, WriteData,
                   Instr);

endmodule