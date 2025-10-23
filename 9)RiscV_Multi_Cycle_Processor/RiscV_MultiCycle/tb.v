module tb(

    );

    reg clk;
    reg reset;
    wire [31:0] WriteData, Adr;
    wire MemWrite;

 // instantiate device to be tested
 top_test dut(clk, reset, WriteData, Adr, MemWrite);
 
 // initialize test
 initial
     begin
     reset <= 1; # 22; reset <= 0;
     end
 
 // generate clock to sequence tests
 always
     begin
     clk <= 1; # 5; clk <= 0; # 5;
     end
 
 // check results
 always @(negedge clk)
 begin
     if(MemWrite) begin
         if(Adr === 100 & WriteData === 25) begin
             $display("Simulation succeeded");
             $stop;
         end 
         else if (Adr !== 96) begin
             $display("Simulation failed");
             $stop;
         end
     end
 end
endmodule

