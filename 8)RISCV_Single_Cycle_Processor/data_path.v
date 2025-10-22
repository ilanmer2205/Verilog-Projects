
module data_path
    
    (input clk, reset,
    input [1:0] ResultSrc,
    input PCSrc, ALUSrc,
    input RegWrite,
    input [1:0] ImmSrc,
    input [2:0] ALUControl,
    input [31:0] ReadData,
    input [31:0] Instr,
    output Zero,
    output [31:0] PC,
    output [31:0] ALUResult, WriteData
    );
    
     wire [31:0] PCNext, PCPlus4, PCTarget;
     wire [31:0] ImmExt;
     wire [31:0] SrcA, SrcB;
     wire [31:0] Result;
     
     wire [4:0] A1;
     wire [4:0] A2;
     wire [4:0] A3;
    
     assign A1 = Instr[19:15];
     assign A2 = Instr[24:20];
     assign A3 = Instr[11:7]; 
     
    // next PC logic
     flopr #(32) pcreg(clk, reset, PCNext, PC);
     adder pcadd4(PC, 32'd4, PCPlus4);
     adder pcaddbranch(PC, ImmExt, PCTarget);
     mux2 #(32) pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
    // register file logic
     Register_File rf(clk, A1, A2, A3, Result, RegWrite, 
         SrcA, WriteData);
     Extend ext(Instr[31:7], ImmSrc, ImmExt);
    // ALU logic
     mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
     ALU alu(SrcA, SrcB, ALUControl, Zero, ALUResult);
     mux3 #(32) resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
    
endmodule
