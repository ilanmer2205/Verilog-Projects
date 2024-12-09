
module a_clk(
    input clk,
    input en,
    output clk_440
    );
    
    reg [16:0]counter=0;
    reg r_clk_440=0;
    
    assign clk_440=r_clk_440;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==113_636) begin
                counter<=0;
                r_clk_440<=~r_clk_440; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule

