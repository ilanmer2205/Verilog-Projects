

module b_clk(
    input clk,
    input en,
    output clk_494
    );
    
    reg [16:0]counter=0;
    reg r_clk_494=0;
    
    assign clk_494=r_clk_494;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==101_240) begin
                counter<=0;
                r_clk_494<=~r_clk_494; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule

