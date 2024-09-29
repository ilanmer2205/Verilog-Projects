`timescale 1ns / 1ps


module tb(

    );
    
    reg clk=0, reset=0, rx=1;
    reg [9:0]tb_data=10'b1000000110; //"3"
    reg [3:0] tb_data_index=0;
    wire tb_out;
    top test_uart(.clk(clk), .reset(reset), .rx(rx), .data(tb_out));
    
    always #10 clk=~clk; //100Mhz-->10nsec
    
    initial begin
        repeat(10) begin
        @(posedge clk)
        rx<=tb_data[tb_data_index];
        tb_data_index<=tb_data_index+1;
        end
    end 

    
endmodule
