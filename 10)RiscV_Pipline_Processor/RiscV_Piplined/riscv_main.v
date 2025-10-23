
module riscv_main
    (
    input clk, reset,
    input [31:0] ReadDataM, 
    input [31:0] InstrF, 
    output [31:0] PCF,
    output MemWriteM,
    output [31:0] ALUResultM, WriteDataM);

    wire RegWriteM, RegWriteW;
    wire [1:0] ResultSrcE, ResultSrcW;
    wire [2:0] ALUControlE;
    wire ALUSrcE;
    wire [1:0] ImmSrcD;
    
    wire StallF, StallD; 
    wire FlushD, FlushE;
    wire [1:0] ForwardAE, ForwardBE;

    wire [4:0] Rs1D, Rs2D;
    wire [4:0] Rs1E, Rs2E;
    wire [4:0] RdE, RdM, RdW;
    wire [31:0] InstrD;

    wire Zero;
    wire PCSrcE;
    wire [6:0] op;
    wire [2:0] func3;
    wire func7;
    
    assign op = InstrD[6:0];
    assign func3 = InstrD[14:12];
    assign func7 = InstrD[30];
    
    control_unit c(clk, reset, op, func3, func7, Zero, FlushE, PCSrcE, RegWriteM,
                    RegWriteW, ResultSrcE, ResultSrcW, MemWriteM, ALUControlE,
                     ALUSrcE, ImmSrcD);

    data_path dp(clk, reset, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE,
                  RegWriteW, ImmSrcD, PCSrcE, ALUSrcE, ALUControlE, ResultSrcW, ReadDataM,
                   InstrF, Zero, PCF, ALUResultM, WriteDataM, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM,
                    RdW, InstrD);
        
    hazard_control hzrd ( Rs1D, Rs1E, Rs2D, Rs2E, RdE, RdM, RdW, PCSrcE, RegWriteM, RegWriteW, ResultSrcE[0],
                          StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);
    
endmodule





 
 