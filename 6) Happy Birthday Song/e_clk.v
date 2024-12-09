
module e_clk(

    input clk,
    input en,
    output clk_659
    );
    
    reg [16:0]counter=0;
    reg r_clk_659=0;
    
    assign clk_659=r_clk_659;
        
    always@(posedge clk) begin
        if (en) begin 
            if (counter==75_873) begin
                counter<=0;
                r_clk_659<=~r_clk_659; end
            else
                counter<= counter +1;
        end
        else
            counter<=0;
    end
    
endmodule
