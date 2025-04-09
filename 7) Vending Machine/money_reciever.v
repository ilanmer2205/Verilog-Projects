module money_reciever( //recieve and save money in the machine
    input clk,
    input cancel_btn,
    input i_rst, m_rst, //i_rst is done by the user while b_rst is done by the machine
    input m_1, m_5, m_10, m_20, //money into the machine
    input inc_1, inc_5, inc_10, inc_20, 
    input enough_payment, 
    
    output reg on_m_1=0, //output to any module that needs a coin input (m_x)
    output reg on_m_5=0, 
    output reg on_m_10=0,
    output reg on_m_20=0,
    output reg en_m_back=0, o_cancel=0,//output to 'return money' model
    output reg on_inc_1=0, on_inc_5=0, on_inc_10=0, on_inc_20=0
    );   
           
   parameter IDLE=5'd0, ON_1=5'd1, OFF_1= 5'd2, ON_5=5'd3, OFF_5= 5'd4, ON_10=5'd5, OFF_10= 5'd6, ON_20=5'd7,
             OFF_20= 5'd8, INC_ON_1= 5'd9, INC_ON_5= 5'd10, INC_ON_10= 5'd11, INC_ON_20= 5'd12,
             INC_OFF_1= 5'd13, INC_OFF_5= 5'd14, INC_OFF_10= 5'd15, INC_OFF_20= 5'd16;       
           
   reg [4:0] m_state=0; 
   reg en_m_1,en_m_5=0,en_m_10=0,en_m_20=0;
   reg r_wait;
              
   always@(posedge clk or posedge i_rst or posedge m_rst) begin //calculates the sum of money being payed each time. 
    if(m_rst || i_rst) begin
        en_m_1<=0;
        en_m_5<=0;
        en_m_10<=0;
        en_m_20<=0;
        o_cancel<=0;
        r_wait<=0; end
        else if(cancel_btn)
            o_cancel<=1; //during cancel cant recieve money. it will reset using m_rst.
            else
            if(!o_cancel) begin//when not canceled can recieve money.
                if( (m_1 ^ m_5 ^ m_10 ^ m_20) && enough_payment==0) begin //if a coin is inserted but not two at the same time. also LED of money back is closed. needs to wait on clk cycle after m_back is closed otherwise coins will keep returning (that's ok)
                    en_m_1<=m_1; //en_m_1 outputs to other model thats needs to recieve m_x
                    en_m_5<=m_5; //a delay of one clk cycle is created regarding the coin input
                    en_m_10<=m_10;
                    en_m_20<=m_20;
                    en_m_back<=1'b0;
                    r_wait<=1; end 
                    else if( !(m_1 || m_5 || m_10|| m_20))begin //if no coins are inserted.
                            en_m_1<=0; //if two equal coins are inserted 10ns~ apart and are only detected for 10ns~ the latter will not register
                            en_m_5<=0;
                            en_m_10<=0;
                            en_m_20<=0; 
                            en_m_back<=1'b0;
                            r_wait<=0; end
                            else if( (m_1 ^ m_5 ^ m_10 ^ m_20) && enough_payment==1) begin //cover the option when payment is enough to avoid letting money back
                                en_m_back<=1'b0; end
                                      en_m_back<=1'b1;
                                
            end
   end     
   
   
   always@(posedge clk) begin //final piece to make a synchronous coin acceptor. it makes sure the coin will be registered for one clock cycle only.     
       if(m_rst || i_rst) begin
            m_state<=IDLE; 
            on_m_1<=0;
            on_m_5<=0;
            on_m_10<=0;
            on_m_20<=0; end
       else
       case(m_state)
        IDLE: begin
            m_state<= en_m_1 ? ON_1:
                      en_m_5 ? ON_5:
                      en_m_10? ON_10:
                      en_m_20? ON_20:
                      inc_1 ? INC_ON_1:
                      inc_5 ? INC_ON_5:
                      inc_10? INC_ON_10:
                      inc_20? INC_ON_20:
                      IDLE; end
        ON_1: begin
            on_m_1<=1;
            m_state<=OFF_1; end
        OFF_1: begin
            on_m_1<=0;
            m_state<= r_wait? OFF_1: IDLE; end
        ON_5:begin
            on_m_5<=1;
            m_state<=OFF_5; end
        OFF_5:begin
            on_m_5<=0;
            m_state<=r_wait? OFF_5: IDLE; end
        ON_10:begin
            on_m_10<=1;
            m_state<=OFF_10; end
        OFF_10:begin
            on_m_10<=0;
            m_state<=r_wait? OFF_10: IDLE; end
        ON_20:begin
            on_m_20<=1;
            m_state<=OFF_20; end
        OFF_20:begin
            on_m_20<=0;
            m_state<=r_wait? OFF_20: IDLE; end
            
        INC_ON_1: begin
            on_inc_1<=1;
            m_state<=INC_OFF_1; end
        INC_OFF_1: begin
            on_inc_1<=0;
            m_state<=inc_1? INC_OFF_1:IDLE; end
        INC_ON_5:begin
            on_inc_5<=1;
            m_state<=INC_OFF_5; end
        INC_OFF_5:begin
            on_inc_5<=0;
            m_state<=inc_5? INC_OFF_5:IDLE; end
        INC_ON_10:begin
            on_inc_10<=1;
            m_state<=INC_OFF_10; end
        INC_OFF_10:begin
            on_inc_10<=0;
            m_state<=inc_10? INC_OFF_10:IDLE; end
        INC_ON_20:begin
            on_inc_20<=1;
            m_state<=INC_OFF_20; end
        INC_OFF_20:begin
            on_inc_20<=0;
            m_state<=inc_20? INC_OFF_20:IDLE; end
        default:m_state<=IDLE;
        
       endcase 
                      
   end    

endmodule
