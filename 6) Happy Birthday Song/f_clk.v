

module f_clk(

    input clk,
    input en,
    output clk_699
    );
    
    reg [16:0]counter=0;
    reg r_clk_699=0;
    
    assign clk_699=r_clk_699;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==71_582) begin
                counter<=0;
                r_clk_699<=~r_clk_699; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule
