module money_reciever( //recieve and save money in the machine
    input clk,
    input i_rst, m_rst, //i_rst is done by the user while b_rst is done by the machine
    input m_1, m_5, m_10, m_20, //money into the machine
    input [5:0]i_am_1, //total sum of 1 coins in the machine. recieve input from 'change_checker'. initial amount of coins is determined before program run.
    input [5:0]i_am_5,
    input [5:0]i_am_10, 
    input enough_ch,
    output reg [2:0] o_new_1, //current amount new coings before there's enough money
    output reg  [1:0] o_new_5,
    output reg o_new_10, o_new_20,
    output reg [5:0] o_am_1=6, //current amount of coings inside the machine
    output reg [5:0] o_am_5=2,
    output reg [5:0] o_am_10=1,
    output reg [2:0] o_am_20=0,
    output reg enough_payment,
    output reg[4:0] payment_in
    );   

    reg en_m_1, en_m_1, en_m_5, en_m_10, en_m_20;
              
   always@(posedge clk or posedge i_rst or posedge m_rst) begin //calculates the sum of money being payed each time. 
    if(m_rst || i_rst) begin
        payment_in<=0;
        enough_payment<=0;end
    else if(m_1 ^ m_5 ^ m_10 ^ m_20)begin //if a coin is inserted but not two at the same time
        en_m_1<=m_1;
        en_m_5<=m_5;
        en_m_10<=m_10;
        en_m_20<=m_20; end
        else if( !(m_1 && m_5 && m_10 && m_20))begin //if no coins are inserted.
                 if (payment_in<=6) begin //after 6 coins can recieve a last coin of any kind and that's it
                    payment_in<=payment_in+ en_m_1+ en_m_5*5 //update the sum
                                 +m_10*10;
                    enough_payment<=0;
                    en_m_1<=0;
                    en_m_5<=0;
                    en_m_10<=0;
                    en_m_20<=0; end
                 else
                    enough_payment<=1;   
        end
   end         
    always@(posedge clk) begin // update current coins in the machine 
        if(m_rst || i_rst) begin
            o_new_1<=0; 
            o_new_5<=0;
            o_new_10<=0;
            o_new_20<=0;
            
            if (i_rst) begin //reset all coins in the machine
                o_am_1<=0;
                o_am_5<=0;
                o_am_10<=0;
                o_am_20<=0;
            end
        end  
        else 
        if(payment_in<=6) begin //if there's still not enough money
            o_new_1<=o_new_1+m_1; //counts and save the o_new coins being added
            o_new_5<=o_new_5+m_5;
            o_new_10<=o_new_10+m_10;
            o_new_20<=o_new_20+m_20; end    
        else
            if(!enough_ch) begin //if there wont be enough change it will be used to return the new coins
            o_new_1<=o_new_1; 
            o_new_5<=o_new_5;
            o_new_10<=o_new_10;
            o_new_20<=o_new_20;end
            else begin //register new coin to the system
            o_new_1<=0; //reset o_new coins
            o_new_5<=0;
            o_new_10<=0;
            o_new_20<=0;
            o_am_1<=o_am_1+o_new_1; //and add it's last value to the total money count
            o_am_5<=o_am_5+o_new_5;
            o_am_10<=o_am_10+o_new_10;
            o_am_20<=o_am_20+o_new_20; end 
    end 
endmodule
