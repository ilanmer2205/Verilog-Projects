module reciever(
    input clk,
    input tick,
    input reset,
    input rx,
    output [7:0] data
    );
    parameter samples=16;
    parameter idle=0;
    parameter next=1;
    
    reg start=0;
    reg [4:0]tick_index=0;
    reg [1:0]state=0;
    reg [3:0]data_index=0;
    reg [9:0]r_data=0;
    
    assign data=r_data[8:1];
    
    always@(posedge clk) begin
        if (reset) begin
            state<=idle;
            tick_index<=0;
            data_index<=0;
            r_data<=1;
        end
    end
    
    always@(posedge clk)
    begin
        case (state)
            idle: begin
                if(rx) begin
                    state<=idle; 
                    tick_index<=0;
                    data_index<=0; end
                else begin
                
                    state<=next; end
            end
            next: begin
                if (tick) begin
                     
                    if (tick_index==(samples)/2 && data_index==0) begin //meaning after 8 ticks for start bit
                        r_data[data_index]<=rx;
                        data_index<=4'b0001;
                        tick_index<=0; end
                    if (tick_index==samples && data_index != 9) begin //every 16 ticks while there is still data or start bit
                        tick_index<=0;
                        r_data[data_index]<=rx;
                        data_index<=data_index+1; end
                    if (tick_index==samples && data_index==9) begin //every 16 tick and for stop bit 
                        tick_index<=0;
                        r_data[data_index]<=rx;
                        data_index<=data_index+1;
                        state<= idle; end
                    else begin //count number of ticks from tick generator
                        tick_index<=tick_index+1; end   
                end
            end  
    endcase  
    end
endmodule
