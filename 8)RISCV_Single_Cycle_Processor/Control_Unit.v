
module Control_Unit(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input Zero,
    output PCSrc,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg [2:0] ALUControl, 
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg Jump
    );
    
    reg [1:0] ALUOp;
    reg Branch;
    
    assign PCSrc= (Branch & Zero) | (Jump);
    
//    assign ALUControl= (ALUOp==2'b00) ? 3'b000 :
//                       (ALUOp==2'b01) ? 3'b001 :
//                       (ALUOp==2'b10) ?   
    //Main Decoder:
    always@ * begin
        case(op)
            7'b0000011: begin //lw= 10010010000
                RegWrite<= 1'b1;
                ImmSrc<= 2'b00;
                ALUSrc<= 1'b1;
                MemWrite<= 1'b0;
                ResultSrc<= 2'b01;
                Branch<= 1'b0;
                ALUOp<= 2'b00;
                Jump<= 1'b0;
            end
            7'b0100011: begin //sw= 00111000000
                RegWrite<= 1'b0;
                ImmSrc<= 2'b01;
                ALUSrc<= 1'b1;
                MemWrite<= 1'b1;
                ResultSrc<= 2'b00; //don't care
                Branch<= 1'b0;
                ALUOp<= 2'b00;
                Jump<= 1'b0;
            end
            7'b0110011: begin //R-Type
                RegWrite<= 1'b1;
                ImmSrc<= 2'b00; //don't care
                ALUSrc<= 1'b0; 
                MemWrite<= 1'b0;
                ResultSrc<= 2'b00;
                Branch<= 1'b0;
                ALUOp<= 2'b10;
                Jump<= 1'b0;
            end
            7'b1100011: begin //beq
                RegWrite<= 1'b0;
                ImmSrc<= 2'b10;
                ALUSrc<= 1'b0;
                MemWrite<= 1'b0;
                ResultSrc<= 2'b00; //don't care
                Branch<= 1'b1;
                ALUOp<= 2'b01;
                Jump<= 1'b0;
            end
            7'b0010011: begin //addi, I Type ALU
                RegWrite<= 1'b1;
                ImmSrc<= 2'b00;
                ALUSrc<= 1'b1;
                MemWrite<= 1'b0;
                ResultSrc<= 2'b00; //don't care
                Branch<= 1'b0;
                ALUOp<= 2'b10;
                Jump<= 1'b0;
            end
            7'b1101111: begin //jal
                RegWrite<= 1'b1;
                ImmSrc<= 2'b11;
                ALUSrc<= 1'b0; //don't care
                MemWrite<= 1'b0;
                ResultSrc<= 2'b10; //don't care
                Branch<= 1'b0;
                ALUOp<= 2'b00; //don't care 
                Jump<= 1'b1;
            end
            default: begin
                RegWrite<= 1'b0;
                ImmSrc<= 2'b00;
                ALUSrc<= 1'b0;
                MemWrite<= 1'b0;
                ResultSrc<= 1'b0;
                Branch<= 1'b0;
                ALUOp<= 2'b00;
                Jump<= 1'b0;
            end    
        endcase
    end
    
    
    //ALU Decoder:
    always@ * begin
        case(ALUOp)
            2'b00:
                ALUControl= 3'b000; // add (lw,sw)
            2'b01:
                ALUControl= 3'b001; // sub (beq) 
            default: 
                case(funct3)
                    3'b000:
                        if({funct7, op[5]}== 2'b11)
                            ALUControl= 3'b001; //sub
                        else // {funct7, op[5]} == 2'b00 | 2'b01 | 2'b10 )
                            ALUControl= 3'b000; // add
                    3'b010:
                        ALUControl= 3'b101; //slt
                    3'b110:
                        ALUControl= 3'b011; //or
                    3'b111:
                        ALUControl= 3'b010; //and
                    default: 
                        ALUControl= 3'b000;
                endcase
//            default:
//                ALUControl= 3'b000;
        endcase   
    end
    
endmodule
