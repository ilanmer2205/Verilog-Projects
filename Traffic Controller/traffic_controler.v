module traffic_controler(
    input clk,
    input rst,
    input on, //switch to turn on the system
    output [2:0] light1,
    output [1:0] light2,
    output led,
    output [2:0]led_check
    );
    
    parameter  S1=2'b00, S2=2'b01, S3=2'b10, S4=2'b11;
    parameter SEC_8=800_000_000, SEC_2=200_000_000; 
    //1 sec is when count==100M. the above was calculated accordingly 
    reg [1:0] state=0;
    reg [2:0] r_light1=0;
    reg [1:0] r_light2=0;
    reg [29:0] count=0; //needs to count up to a maximum of 800*10^6
    
    assign led_check=r_light1;
    assign light1=r_light1;
    assign light2=r_light2;
    assign led=on;
    
    always@(posedge clk, posedge rst) begin
        if (rst) begin //if rst==1
            count<=0;
            r_light1<=0;
            r_light2<=0;
            state<=S1;
        end 
        else if (!on) begin //if rst==0 and on==0. meaning the system is not turned on
            r_light1<=0;
            r_light2<=0;
            count<=0;
            state<=S1; end

        else // rst==0 and on==1
            case(state) 
    
            S1: begin 
                r_light1<=3'b100; //red
                r_light2<=2'b01; // green
                
                if (count>=SEC_8) begin //after 8 sec in S1 state go to the next state
                    count<=0;
                    state<=S2; end
                else begin //else inc counter and refresh state
                    count<=count+1;
                    state<=S1; end 
                end
            S2: begin
                r_light1<=3'b010; //yellow
                r_light2<=2'b10; // red
                
                if (count>=SEC_2) begin //after 2 sec in S1 state go to the next state
                    count<=0;
                    state<=S3; end
                else begin //else inc counter and refresh state
                    count<=count+1;
                    state<=S2; end 
                 end
            S3: begin
                r_light1<=3'b001; //green
                r_light2<=2'b10; //red
                
                if (count>=SEC_8) begin //after 8 sec in S1 state go to the next state
                    count<=0;
                    state<=S4; end
                else begin //else inc counter and refresh state
                    count<=count+1;
                    state<=S3; end 
                end
            S4: begin
                r_light1<=3'b010;
                r_light2<=2'b10;
                
                if (count>=SEC_2) begin //after 2 sec in S1 state go to the next state
                    count<=0;
                    state<=S1; end
                else begin //else inc counter and refresh state
                    count<=count+1;
                    state<=S4; end 
                end
            default: state<=S1;
        endcase
    end
    
endmodule
