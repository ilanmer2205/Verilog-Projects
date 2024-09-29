
module top(
    input clk,
    input reset,
    input rx,
    output [7:0] data
    );
    
    wire w_tick;
    
    baud_generator b_g (.clk(clk), .reset(reset), .tick(w_tick));
    
    reciever reciever1(.clk(clk), .tick(w_tick), .reset(reset), .rx(rx), .data(data));
    
endmodule

