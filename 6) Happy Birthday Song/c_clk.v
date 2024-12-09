module c_clk(
    input clk,
    input en,
    output clk_523
    );
    
    reg [16:0]counter=0;
    reg r_clk_523=0;
    
    assign clk_523=r_clk_523;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==95_602) begin
                counter<=0;
                r_clk_523<=~r_clk_523; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
   
endmodule
