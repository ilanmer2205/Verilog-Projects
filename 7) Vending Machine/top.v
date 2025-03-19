module top_module(
    input clk,
    input btn_mid,
    input btn_u,
    input btn_l,
    input btn_d,
    input btn_r,
    output give_1, give_5, give_10, give_20, give_back,
    output give_candy,
    output [2:0] current_mode,
    output [0:6] seg,       
    output [3:0] an
    
    );
    
    wire w_btn_u, w_btn_l, w_btn_d, w_btn_r; //output of debouncer
    wire w_btn_mid;
    wire m_1, m_5, m_10, m_20;
    wire on_m_1, on_m_5, on_m_10, on_m_20;
    wire inc_1,inc_5,inc_10,inc_20;
    wire cancel_btn, i_rst, m_rst, i_cash_rst;

    wire [2:0] w_new_1;
    wire [1:0] w_new_5; 
    wire w_new_10, w_new_20;
    
    wire w_enough_payment, w_enough_change;
    wire [4:0] w_payment_in;
//    wire [5:0] sm_o_am_1,sm_o_am_5,sm_o_am_10; //'store_money' output
//    wire [2:0] sm_o_am_20;
    wire [4:0] w_counter_ch_1;
    wire [1:0] w_counter_ch_5;
    wire w_counter_ch_10;
    wire [5:0] o_am_1, o_am_5, o_am_10;
    wire [2:0] o_am_20;   
    
    wire [5:0] m_o_am_1, m_o_am_5, m_o_am_10; //'mode' output
    wire [2:0] m_o_am_20;
    wire [3:0] w_vm_state;
    wire [4:0] w_am_return;
    wire w_m_cancel;
    wire w_give_1 ,w_give_5 ,w_give_10, w_give_20, w_give_candy;
    wire [6:0] w_tot_am;
    wire w_en_m_back, w_cancel;
    wire on_inc_1, on_inc_5, on_inc_10, on_inc_20;
    
    debouncer d_u(clk, btn_u, w_btn_u);
    debouncer d_l(clk, btn_l, w_btn_l);
    debouncer d_d(clk, btn_d, w_btn_d);
    debouncer d_r(clk, btn_r, w_btn_r);
    debouncer d_m(clk, btn_mid, w_btn_mid);
    
      switch_mode sm(.clk(clk), .btn_mid(w_btn_mid), .i_btn_u(w_btn_u), .i_btn_l(w_btn_l), .i_btn_r(w_btn_r),
                     .i_btn_d(w_btn_d), .m_1(m_1),
                     .m_5(m_5), .m_10(m_10), .m_20(m_20), .i_rst(i_rst), .cancel_btn(cancel_btn),
                      .i_cash_rst(i_cash_rst), .inc_1(inc_1), .inc_5(inc_5), .inc_10(inc_10),
                      .inc_20(inc_20) ,.current_mode(current_mode));

    
    money_reciever mr(.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .m_1(m_1), .m_5(m_5),
                       .m_10(m_10), .cancel_btn(cancel_btn), .m_20(m_20),
                        .inc_1(inc_1), .inc_5(inc_5), .inc_10(inc_10), .inc_20(inc_20),
                        .on_m_1(on_m_1), .on_m_5(on_m_5), .on_m_10(on_m_10), .on_m_20(on_m_20),
                        .enough_payment(w_enough_payment), .en_m_back(w_en_m_back), .o_cancel(w_cancel),
                         .on_inc_1(on_inc_1), .on_inc_5(on_inc_5), .on_inc_10(on_inc_10), .on_inc_20(on_inc_20));
    
    payment_reciever pr(.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .m_1(on_m_1), .m_5(on_m_5),
                       .m_10(on_m_10), .m_20(on_m_20), .o_new_1(w_new_1), .o_new_5(w_new_5), .o_new_10(w_new_10), .o_new_20(w_new_20),
                        .enough_payment(w_enough_payment), .payment_in(w_payment_in));
    
    check_change cc (.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .payment_in(w_payment_in),
                      .i_am_1(o_am_1), .i_am_5(o_am_5), .i_am_10(o_am_10), 
                        .counter_ch_1(w_counter_ch_1), .counter_ch_5(w_counter_ch_5),
                         .counter_ch_10(w_counter_ch_10), .enough_ch(w_enough_change));    
                                           
    store_money st_m(.clk(clk), .i_cash_rst(i_cash_rst), .on_inc_1(on_inc_1), .on_inc_5(on_inc_5), .on_inc_10(on_inc_10), .on_inc_20(on_inc_20),
//                      .i_new_1(w_new_1), .i_new_5(w_new_5),.i_new_10(w_new_10), .i_new_20(w_new_20),
                       .current_mode(current_mode), .i_am_1(m_o_am_1), .i_am_5(m_o_am_5), .i_am_10(m_o_am_10), .i_am_20(m_o_am_20),
                        .o_am_1(o_am_1), .o_am_5(o_am_5),.o_am_10(o_am_10), .o_am_20(o_am_20), .tot_am(w_tot_am));
    
    mode mo(.clk(clk), .i_rst(i_rst), .cancel_btn(cancel_btn), .enough_ch(w_enough_change), .enough_payment(w_enough_payment),
              .counter_ch_10(w_counter_ch_10), .counter_ch_5(w_counter_ch_5),.counter_ch_1(w_counter_ch_1), .i_new_20(w_new_20),
               .i_new_10(w_new_10), .i_new_5(w_new_5), .i_new_1(w_new_1), .i_am_1(o_am_1), .i_am_5(o_am_5), .i_am_10(o_am_10),
                .i_am_20(o_am_20),.o_am_1(m_o_am_1), .o_am_5(m_o_am_5), .o_am_10(m_o_am_10), .o_am_20(m_o_am_20),
                .o_vm_state(w_vm_state), .am_return(w_am_return), .m_cancel(w_m_cancel), .give_20(w_give_20),
                 .give_10(w_give_10), .give_5(w_give_5), .give_1(w_give_1), .m_rst(m_rst), .give_candy(give_candy));
                  
    return_money rm(.m_1(m_1), .m_5(m_5), .m_10(m_10), .m_20(m_20),
                     .m_give_1(w_give_1), .m_give_5(w_give_5), .m_give_10(w_give_10), .m_give_20(w_give_20), .en_m_back(w_en_m_back),
                      .enough_payment(w_enough_payment), .o_give_1(give_1), .o_give_5(give_5), .o_give_10(give_10),
                       .i_cancel(w_cancel),.o_give_20(give_20), .o_give_back(give_back));        
    
    seg_7_control(.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .am_return(w_am_return),.vm_state(w_vm_state), .current_mode(current_mode),
                   .tot_am(w_tot_am), .seg(seg), .an(an));
endmodule
