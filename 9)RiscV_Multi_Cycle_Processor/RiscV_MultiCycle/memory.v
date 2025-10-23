

module memory
    #(MEM_DEPTH=63) //length can be 2^32-1
    (
//    input rst,
    input clk,
    input [31:0] A, WD, //PC input
    input we,
    output [31:0] RD
    );
    
    reg [31:0] mem [MEM_DEPTH: 0];
    
    initial
    $readmemh("riscv_test.txt",mem);
     
    assign RD = mem[ A[31:2] ];
    
    always@ (posedge clk) begin
        if(we) mem[A[31:2]] <= WD; 
    end
    
endmodule