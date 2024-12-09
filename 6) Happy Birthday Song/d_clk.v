

module d_clk(
    input clk,
    input en,
    output clk_587
    );
    
    reg [16:0]counter=0;
    reg r_clk_587=0;
    
    assign clk_587=r_clk_587;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==85_179) begin
                counter<=0;
                r_clk_587<=~r_clk_587; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule
