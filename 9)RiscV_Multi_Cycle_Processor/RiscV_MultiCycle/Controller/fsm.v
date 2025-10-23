module fsm(
    input clk,
    input [6:0] op,
    input Zero,
    input reset,
    output reg Branch,
    output reg PCUpdate,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ALUSrcA,
    output reg AdrSrc,
    output reg [1:0] ALUOp,
    output reg IRWrite
    );
    
    localparam FETCH = 4'd0, DECODE = 4'd1, MEMADR = 4'd2, MEMREAD = 4'd3, MEMWB = 4'd4,
                MEMWRITE = 4'd5, EXECUTER = 4'd6, ALUWB = 4'd7, EXECUTEI = 4'd8,
                  JAL = 4'd9, BEQ = 4'd10, ERROR = 4'd11; 

    
    reg [3:0] next_state, current_state;
    reg err_reg;

    always @(posedge clk) begin
        if (reset)
            current_state <= FETCH;
        else
            current_state <= next_state;
    end

    always @(*) begin 
        case(current_state)
            FETCH: next_state = DECODE;
            DECODE: 
                begin
                    case (op) 
                        7'b0000011, 7'b0100011: next_state = MEMADR;
                        7'b0110011: next_state = EXECUTER;
                        7'b0010011: next_state = EXECUTEI;
                        7'b1101111: next_state = JAL;
                        7'b1100011: next_state = BEQ;
                        default: next_state = ERROR;
                    endcase    
                end    
            MEMADR: 
                if (op == 7'b0000011) next_state = MEMREAD;
                else if (op == 7'b0100011) next_state = MEMWRITE; 
                else  next_state = ERROR;  
            MEMREAD: next_state = MEMWB;
            MEMWB: next_state = FETCH;
            MEMWRITE: next_state = FETCH;
            EXECUTER: next_state = ALUWB;
            ALUWB: next_state = FETCH;
            EXECUTEI: next_state = ALUWB;
            JAL: next_state = ALUWB;
            BEQ: next_state = FETCH;
            ERROR: next_state = FETCH;
            default: next_state = FETCH;
        endcase
    end

    always @(*) begin 
        // defaults
        Branch = 1'b0;
        PCUpdate = 1'b0;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 2'b00;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        AdrSrc = 1'b0;
        ALUOp = 2'b00;
        IRWrite = 1'b0;
        err_reg = 1'b0;
        
        case(current_state)
            FETCH: begin
                AdrSrc = 1'b0;
                ALUSrcA = 2'b00;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                ResultSrc = 2'b10;
                PCUpdate = 1'b1;
                IRWrite = 1'b1;
            end
            DECODE: begin
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b01;
                ALUOp = 2'b00;
            end
            MEMADR: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ALUOp = 2'b00;
            end
            MEMREAD: begin
                ResultSrc = 2'b00;
                AdrSrc = 1'b1;
            end
            MEMWB: begin
                ResultSrc = 2'b01;
                RegWrite = 1'b1;
            end
            MEMWRITE: begin
                ResultSrc = 2'b00;
                AdrSrc = 1'b1;
                MemWrite = 1'b1;
            end
            EXECUTER: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b00;
                ALUOp = 2'b10;
            end
            ALUWB: begin
                RegWrite = 1'b1;
                ResultSrc = 2'b00;
            end
            EXECUTEI: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ALUOp = 2'b10;
            end
            JAL: begin
                PCUpdate = 1'b1;
                ALUSrcA = 2'b01; 
                ALUSrcB = 2'b10; 
                ALUOp = 2'b00;
                ResultSrc = 2'b00;
            end
            BEQ: begin
                Branch = 1'b1;
                ALUSrcA = 2'b10; 
                ALUSrcB = 2'b00; 
                ALUOp = 2'b01;
                ResultSrc = 2'b00;
            end
            ERROR: err_reg = 1'b1;
        endcase
    end
    
endmodule