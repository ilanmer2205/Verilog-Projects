
module Control_Unit(
    input clk, 
    input reset,
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input Zero,
    output PCWrite,
    output AdrSrc,
    output MemWrite,
    output IRWrite,
    output [1:0] ResultSrc,
    output [2:0] ALUControl, 
    output [1:0] ALUSrcA,
    output [1:0] ALUSrcB,
    output [1:0] ImmSrc,
    output RegWrite
    );
    
    wire [1:0] ALUOp;
    wire Branch;
    wire PCUpdate;
    
    assign PCWrite= (Branch & Zero) | (PCUpdate);
    
    fsm fsm(clk, op, Zero, reset, Branch, PCUpdate, RegWrite, MemWrite, ResultSrc, ALUSrcB, ALUSrcA, AdrSrc, ALUOp, IRWrite);

    ALU_Decoder aludec (funct3, funct7, op, ALUOp, ALUControl);

    Instr_Decoder instrdec(op, ImmSrc);

endmodule