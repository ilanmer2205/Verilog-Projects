
module extend(
    input [31:7] Instr, //input from Instruction Memory
    input [1:0] ImmSrc, //input from control
    output [31:0] ImmExt
    );
    
    
    //
    assign ImmExt= (ImmSrc==2'b00) ? {{20{Instr[31]}}, Instr[31:20]}: // I type
                   (ImmSrc==2'b01) ? {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}: // S type
                   (ImmSrc==2'b10) ? {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}: // B type
                                     {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}; // J type
                   
endmodule