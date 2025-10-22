

module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] ALUControl,
    output Zero,
    output reg [31:0] ALUResult
    );
    
    //Set of operation based on page 247
//    assign ALUResult= (ALUControl==3'b000) ? (SrcA + SrcB) : 
//                      (ALUControl==3'b001) ? (SrcA - SrcB) :
//                      (ALUControl==3'b010) ? (SrcA & SrcB) :
//                                            (SrcA | SrcB); //  (ALUControl==2'b11)
    always@ (*) begin
        case (ALUControl) 
            3'b000: ALUResult= (SrcA + SrcB);
            3'b001: ALUResult= (SrcA - SrcB);
            3'b010: ALUResult= (SrcA & SrcB);
            3'b011: ALUResult= (SrcA | SrcB);
            3'b101: if (SrcA < SrcB) ALUResult=1;
                    else ALUResult=0; //slt
            default: ALUResult=0;
        endcase
    end  
                    
    assign Zero= (ALUResult==0) ? 1 : 0; 
                   
endmodule
 