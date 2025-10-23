module dmem_tb
    #(MEM_DEPTH=63) //length can be 2^32-1
    (
    input clk,
//    input rst,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output [31:0] RD
    );
    
    reg [31:0] mem [MEM_DEPTH: 0];
    
    assign RD= mem[ A[31:2] ];
    
    always@ (posedge clk) begin
         if (WE) mem[ A[31:2] ]<=WD;
    end
endmodule
