module g_clk_low(

    input clk,
    input en,
    output clk_392
    );
    
    reg [16:0]counter=0;
    reg r_clk_392=0;
    
    assign clk_392=r_clk_392;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==127_551) begin
                counter<=0;
                r_clk_392<=~r_clk_392; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule
