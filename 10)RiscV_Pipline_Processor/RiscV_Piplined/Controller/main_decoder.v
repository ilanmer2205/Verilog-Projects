
module main_decoder (
	input [6:0] op,
	output reg [1:0] ResultSrc,
	output reg MemWrite,
	output reg Branch, ALUSrc,
	output reg RegWrite, Jump,
	output reg [1:0] ImmSrc,
	output reg [1:0] ALUOp);


	always@ * begin
        case(op)
            7'b0000011: begin //lw= 10010010000
                RegWrite = 1'b1;
                ImmSrc = 2'b00;
                ALUSrc = 1'b1;
                MemWrite = 1'b0;
                ResultSrc = 2'b01;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
            end
            7'b0100011: begin //sw= 00111000000
                RegWrite = 1'b0;
                ImmSrc = 2'b01;
                ALUSrc = 1'b1;
                MemWrite = 1'b1;
                ResultSrc = 2'b00; //don't care
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
            end
            7'b0110011: begin //R-Type
                RegWrite = 1'b1;
                ImmSrc = 2'b00; //don't care
                ALUSrc = 1'b0; 
                MemWrite = 1'b0;
                ResultSrc = 2'b00;
                Branch = 1'b0;
                ALUOp = 2'b10;
                Jump = 1'b0;
            end
            7'b1100011: begin //beq
                RegWrite = 1'b0;
                ImmSrc = 2'b10;
                ALUSrc = 1'b0;
                MemWrite = 1'b0;
                ResultSrc = 2'b00; //don't care
                Branch = 1'b1;
                ALUOp = 2'b01;
                Jump = 1'b0;
            end
            7'b0010011: begin //addi, I Type ALU
                RegWrite = 1'b1;
                ImmSrc = 2'b00;
                ALUSrc = 1'b1;
                MemWrite = 1'b0;
                ResultSrc = 2'b00; //don't care
                Branch = 1'b0;
                ALUOp = 2'b10;
                Jump = 1'b0;
            end
            7'b1101111: begin //jal
                RegWrite = 1'b1;
                ImmSrc = 2'b11;
                ALUSrc = 1'b0; //don't care
                MemWrite = 1'b0;
                ResultSrc = 2'b10; //don't care
                Branch = 1'b0;
                ALUOp = 2'b00; //don't care 
                Jump = 1'b1;
            end
            default: begin
                RegWrite = 1'b0;
                ImmSrc = 2'b00;
                ALUSrc = 1'b0;
                MemWrite = 1'b0;
                ResultSrc = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
            end    
        endcase
    end
endmodule