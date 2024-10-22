`timescale 1ns / 1ps

/// change SEC_8 AND SEC_2 in traffic_controller.v to smaller number for simulation

module tb(

    );
    
    reg clk_tb=0, rst_tb=0, on_tb=0;
    wire [2:0]light1_tb;
    wire [1:0]light2_tb;
    wire led_tb;
    
    traffic_controler t_c_tb(.clk(clk_tb), .rst(rst_tb), .on(on_tb), .light1(light1_tb), .light2(light2_tb));
    
    always #5 clk_tb<=~clk_tb;
    
    initial begin
        #20; on_tb<=1;

    end
    
endmodule
