
module alu_decoder (
 input [2:0] funct3,
 input [1:0] funct7b5,
 input [1:0] ALUOp,
 output reg [2:0] ALUControl);

	always@ * begin
        case(ALUOp)
            2'b00:
                ALUControl= 3'b000; // add (lw,sw)
            2'b01:
                ALUControl= 3'b001; // sub (beq) 
            default: 
                case(funct3)
                    3'b000:
                        if(funct7b5 == 2'b11)
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