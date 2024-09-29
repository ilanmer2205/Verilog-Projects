module baud_generator(
    input clk,
    input reset,
    output tick
    );
    
    parameter baud_rate=9600;
    parameter fpga_clk=100_000_000;
    parameter samples=16;
    parameter sample_count= fpga_clk/(baud_rate*samples); //=651
    
    reg [9:0] counter=0;
    reg r_tick=0;
    
    assign tick=r_tick;
    
    always@( posedge clk) begin
        if(reset) begin
            counter<=0;
            r_tick<=0; end
         else begin   
            if (counter<651) begin //every 651 generates 1 tick. there is 16 ticks/samples in one data bit.
                counter<=counter+1;
                r_tick<=0; end
            else begin // meaning: counter==651
                counter<=0;
                r_tick<=1; end
         end
     end
    
    
endmodule
