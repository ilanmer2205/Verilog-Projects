
module top_test(
    input   clk, reset,
    output  [31:0] WriteData, Adr,
    output  MemWrite);
    
    
    wire [31:0] ReadData;

    // instantiate processor and memories
    riscv_main rvsingle(clk, reset, ReadData, Adr, MemWrite, WriteData);
        
    memory ram(clk, Adr, WriteData, MemWrite, ReadData);

    
endmodule
