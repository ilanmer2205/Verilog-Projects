
module g_clk(

    input clk,
    input en,
    output clk_784
    );
    
    reg [16:0]counter=0;
    reg r_clk_784=0;
    
    assign clk_784=r_clk_784;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==63_776) begin
                counter<=0;
                r_clk_784<=~r_clk_784; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule
