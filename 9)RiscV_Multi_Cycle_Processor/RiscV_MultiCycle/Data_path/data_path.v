
module data_path
    
    (input clk, reset,   
    input [31:0] ReadData,
    input PCWrite,
    input AdrSrc,
    input IRWrite,
    input [1:0] ResultSrc,
    input [2:0] ALUControl, 
    input [1:0] ALUSrcA,
    input [1:0] ALUSrcB,
    input [1:0] ImmSrc,
    input RegWrite,
    output Zero,
    output [31:0] Adr,
    output [31:0] WriteData,
    output [31:0] Instr //??
    //output MemWrite  //for timing report
    );
    
     wire [31:0] PC;
     wire [31:0] OldPC;
     wire [31:0] ImmExt;
     wire [31:0] Data;
     wire [31:0] A;
     wire [31:0] SrcA, SrcB;
     wire [31:0] ALUResult;
     wire [31:0] ALUOut;
     wire [31:0] Result;
     
     wire [4:0] A1;
     wire [4:0] A2;
     wire [4:0] A3;
    
    wire [31:0] RD1, RD2;

     assign A1 = Instr[19:15];
     assign A2 = Instr[24:20];
     assign A3 = Instr[11:7]; 
     
    // next PC logic
     flopenr #(32) pcregen(clk, reset, PCWrite, Result, PC);
     mux2 #(32) adrmux (PC, Result, AdrSrc, Adr);
    
     flopenr #(32) oldpcregen(clk, reset, IRWrite, PC, OldPC);
     flopenr #(32) instregen(clk, reset, IRWrite, ReadData, Instr);
     flopr #(32) datareg(clk, reset, ReadData, Data);
    // register file logic
     Register_File rf (clk, A1, A2, A3, Result, RegWrite, 
         RD1, RD2);  
      flopr #(32) rfreg1 (clk, reset, RD1, A);
      flopr #(32) rfreg2 (clk, reset, RD2, WriteData);
              
     Extend ext (Instr[31:7], ImmSrc, ImmExt);

    // ALU logic
     mux3 #(32) srcbmux(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
     mux3 #(32) srcamux(PC, OldPC, A, ALUSrcA, SrcA);
     ALU alu (SrcA, SrcB, ALUControl, Zero, ALUResult);

     flopr #(32) alureg(clk, reset, ALUResult, ALUOut);
     mux3 #(32) resultmux(ALUOut, Data, ALUResult, ResultSrc, Result);
    
endmodule





//module data_path
    
//    (input clk, reset,   
//    input [31:0] ReadData,
//    input PCWrite,
//    input AdrSrc,
//    input IRWrite,
//    input [1:0] ResultSrc,
//    input [2:0] ALUControl, 
//    input ALUSrcA,
//    input ALUSrcB,
//    input [1:0] ImmSrc,
//    input RegWrite,
//    output [31:0] Adr,
//    output [31:0] WriteData,
//    output [31:0] Instr //??
//    //output MemWrite  //for timing report
//    );
    
//     wire [31:0] PCNext, PC;
//     wire [31:0] OldPC;
//     wire [31:0] ImmExt;
//     wire [31:0] Data;
//     wire [31:0] A;
//     wire [31:0] SrcA, SrcB;
//     wire [31:0] ALUResult;
//     wire [31:0] ALUOut;
//     wire [31:0] Result;
     
//     wire [4:0] A1;
//     wire [4:0] A2;
//     wire [4:0] A3;
    
//    wire [31:0] RD1, RD2;
    
//     assign A1 = Instr[19:15];
//     assign A2 = Instr[24:20];
//     assign A3 = Instr[11:7]; 
     
//    // next PC logic
//     flopenr #(32) pcregen(clk, reset, PCWrite, PCNext, PC);
//     mux2 #(32) adrmux (PC, Result, AdrSrc, Adr);
    
//     flopenr #(32) oldpcregen(clk, reset, PC, OldPC, IRWrite);
//     flopenr #(32) instregen(clk, reset, PC, Instr, IRWrite);
//     flopr #(32) datareg(clk, ReadData, Data);
//    // register file logic
//     Register_File rf (clk, A1, A2, A3, Result, RegWrite, 
//         RD1, RD2);  
//      flopr #(32) rfreg1 (clk, RD1, A);
//      flopr #(32) rfreg2 (clk, RD2, WriteData);
              
//     Extend ext (Instr[31:7], ImmSrc, ImmExt);

//    // ALU logic
//     mux3 #(32) srcbmux(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
//     mux3 #(32) srcamux(PC, OldPC, A, ALUSrcA, SrcA);
//     ALU alu (SrcA, SrcB, ALUControl, Zero, ALUResult);

//     flopr #(32) alureg(clk, reset, ALUResult, ALUOut);
//     mux3 #(32) resultmux(ALUOut, Data, ALUResult, ResultSrc, Result);
    
//endmodule

