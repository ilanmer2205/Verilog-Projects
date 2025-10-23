

module Register_File
    #(REG_NUM=32)
    (
    input clk,
//    input rst,
    input [4:0] A1, 
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3, //Write Enable: in load=1 in store=0
    output [31:0] RD1,
    output [31:0] RD2
    );
    
    reg [31:0] reg_mem [REG_NUM-1: 0];
    
    //NOTE: x0 is hard wired '0'
    assign RD1 = A1==0 ? 0 : reg_mem[A1];
    assign RD2 = A2==0 ? 0 : reg_mem[A2];
    

    always@ (posedge clk) begin
         if(WE3 && (A3 !=0) )
            reg_mem[A3]<= WD3;           
    end
endmodule




//if (rst)
//            for( i=0; i<REG_NUM+1; i=i+1) begin
//                reg_mem[i]<=32'h0;
//            end 
//        else