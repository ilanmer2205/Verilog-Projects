module top_module(
    input clk,
    input btn_mid,
    input btn_u,
    input btn_l,
    input btn_d,
    input btn_r,
    output give_1, give_5, give_10, give_20,
    output give_candy,
    output [1:0] current_mode
    
    );
    
    wire w_btn_u, w_btn_l, w_btn_d, w_btn_r; //output of debouncer
    wire w_btn_mid;
    wire m_1, m_5, m_10, m_20;
    wire cancel_btn, i_rst, m_rst;
    wire clk_1hz, clk_2hz;
    wire [5:0] mro_am_1,mro_am_5,mro_am_10; //'money reciever' output
    wire [5:0] cco_am_1,cco_am_5,cco_am_10; //'check change' output
    wire [2:0] w_new_1;
    wire [1:0] w_new_5; 
    wire w_new_10;
    wire w_enough_payment, w_enough_change;
    wire [4:0] w_payment_in;
    wire [4:0] w_counter_ch_1;
    wire [1:0] w_counter_ch_5;
    wire w_counter_ch_10;
    wire [3:0] w_vm_state;
    wire [4:0] w_am_change;
    wire w_m_cancel;
    wire w_give_1 ,w_give_5 ,w_give_10, w_give_candy;
    wire [6:0] w_seg;
    wire [3:0] w_an;
    
    debouncer d_u(clk, btn_u, w_btn_u);
    debouncer d_l(clk, btn_l, w_btn_l);
    debouncer d_d(clk, btn_d, w_btn_d);
    debouncer d_r(clk, btn_r, w_btn_r);
    debouncer d_m(clk, btn_mid, w_btn_mid);
    
    switch_mode sm(clk, w_btn_mid, w_btn_u, w_btn_l, w_btn_r, w_btn_d, m_1,
                     m_5, m_10, m_20, i_rst, cancel_btn, current_mode);
    
    clk_1hz clk_1(clk, i_rst, clk_1hz);
    clk_2hz clk_2(clk, i_rst, clk_2hz);
    
    money_reciever mr(.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .m_1(m_1), .m_5(m_5),
                       .m_10(m_10), .m_20(m_20), .i_am_1(cco_am_1), .i_am_5(cco_am_5),
                        .i_am_10(cco_am_10), .o_am_1(mro_am_1), .o_am_5(mro_am_5),
                         .o_am_10(mro_am_1),.o_new_1(w_new_1), .o_new_5(w_new_5),
                          .o_new_10(w_new_10), .enough_payment(w_enoguh_payment),
                           .payment_in(w_payment_in));
    
    check_change cc (.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .payment_in(w_payment_in),
                      .i_am_1(mro_am_1), .i_am_5(mro_am_5), .i_am_10(mro_am_10),
                       .o_am_1(cco_am_1), .o_am_5(cco_am_5), .o_am_10(cco_am_10), 
                        .counter_ch_1(w_counter_ch_1), .counter_ch_5(w_counter_ch_5),
                         .counter_ch_10(w_counter_ch_10), .enough_ch(w_enough_change));                      
    
    mode mo(.clk(clk), .clk_1hz(clk_1hz), .clk_2hz(clk_2hz), .i_rst(i_rst),
             .cancel_btn(cancel_btn), .enough_ch(w_enough_change), .enough_payment(w_enough_payment),
              .counter_ch_10(w_counter_ch_10), .counter_ch_5(w_counter_ch_5),
               .counter_ch_1(w_counter_ch_1), .i_new_10(w_new_10), .i_new_5(w_new_5),
                .i_new_1(w_new_1), .o_vm_state(w_vm_state), .am_change(w_am_change),
                 .m_cancel(w_m_cancel), .give_10(w_give_10), .give_5(w_give_5),
                  .give_1(w_give_1), .m_rst(m_rst), .give_candy(give_candy));
                  
    return_money rm(.m_1(m_1), .m_5(m_5), .m_10(m_10), .m_20(m_20),
                     .ch_give_1(w_give_1), .ch_give_5(w_give_5),
                      .ch_give_10(w_give_10), .enough_payment(w_enough_payment),
                       .o_give_1(give_1), .o_give_5(give_5), .o_give_10(give_10),
                        .o_give_20(give_20));        
    
    seg_7_control(.clk(clk), .i_rst(i_rst), .m_rst(m_rst), .m_cancel(w_m_cancel),
                   .am_change(w_am_change), .payment_in(w_payment_in),
                    .vm_state(w_vm_state), .seg(w_seg), .an(w_an));
endmodule
