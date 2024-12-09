module main(
    input clk,
    input on,
    output sound
    );
    
    parameter BEAT=44_444_444, BREAK=10_000_000; //number of tick of 1 beat when beat rate is 135 beats/min
    //BEAT=400_000
    reg [4:0]note_num=0;
    reg [25:0]timer=0;
    reg r_sound=0;
    reg break=1, z_halfs=1;
    
    reg[2:0] half_beats=0; //to count half beats. In this songs: up to 4
    
    reg en_a=0, en_b=0, en_c=0, en_d=0, en_e=0, en_f=0, en_g=0, en_g_low=0, en_a_high=0, en_b_high=0, en_c_high=0;
    wire sound_a, sound_b, sound_c, sound_d, sound_e, sound_f, sound_g, sound_g_low, sound_a_high, sound_b_high, sound_c_high;
    a_clk a_sound(.clk(clk), .en(en_a), .clk_440(sound_a));
    b_clk b_sound(.clk(clk), .en(en_b), .clk_494(sound_b));
    c_clk c_sound(.clk(clk), .en(en_c), .clk_523(sound_c));
    d_clk d_sound(.clk(clk), .en(en_d), .clk_587(sound_d));
    e_clk e_sound(.clk(clk), .en(en_e), .clk_659(sound_e));
    f_clk f_sound(.clk(clk), .en(en_f), .clk_699(sound_f));
    g_clk g_sound(.clk(clk), .en(en_g), .clk_784(sound_g));
    g_clk_low g_low_sound(.clk(clk), .en(en_g_low), .clk_392(sound_g_low));
    
    always@(posedge clk) begin
        if (on) begin
            case (note_num)
                5'd0: begin
                    if (half_beats==1) begin //when first note is complete
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd1; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g_low<=1;
                        note_num<=5'd0; end
                end
                5'd1: begin
                    if (half_beats==1) begin //when second note is complete
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd2; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g_low<=1;
                        note_num<=5'd1; end
                end
                5'd2: begin
                    if (half_beats==2) begin 
                        half_beats<=0;
                        en_a<=0;
                        note_num<=5'd3; end
                    else begin
    //                    r_sound<=sound_b;
                        en_a<=1;
                        note_num<=5'd2; end
                end
                5'd3: begin
                    if (half_beats==2) begin 
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd4; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_g_low<=1;
                        note_num<=5'd3; end //current
                end
                5'd4: begin
                    if (half_beats==2) begin 
                        half_beats<=0;
                        en_c<=0;
                        note_num<=5'd5; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_c<=1;
                        note_num<=5'd4; end //current
                end
                5'd5: begin
                    if (half_beats==3) begin 
                        half_beats<=0;
                        en_b<=0;
                        note_num<=5'd6; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_b<=1;
                        note_num<=5'd5; end //current
                end
                5'd6: begin
                    if (half_beats==1) begin 
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd7; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_g_low<=1;
                        note_num<=5'd6; end //current
                end
                5'd7: begin
                    if (half_beats==1) begin 
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd8; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_g_low<=1;
                        note_num<=5'd7; end //current
                end
                5'd8: begin
                    if (half_beats==2) begin 
                        half_beats<=0;
                        en_a<=0;
                        note_num<=5'd9; end //next
                    else begin
    //                    r_sound<=sound_b;
                        en_a<=1;
                        note_num<=5'd8; end //current
                end
                5'd9: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd10; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g_low<=1;
                        note_num<=5'd9; end
                end
                5'd10: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_d<=0;
                        note_num<=5'd11; end
                    else begin
    //                    r_sound<=sound_a;
                        en_d<=1;
                        note_num<=5'd10; end
                end
                5'd11: begin
                    if (half_beats==3) begin //when first note is complete
                        half_beats<=0;
                        en_c<=0;
                        note_num<=5'd12; end
                    else begin
    //                    r_sound<=sound_a;
                        en_c<=1;
                        note_num<=5'd11; end
                end
                5'd12: begin
                    if (half_beats==1) begin //when first note is complete
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd13; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g_low<=1;
                        note_num<=5'd12; end
                end
                5'd13: begin
                    if (half_beats==1) begin //when first note is complete
                        half_beats<=0;
                        en_g_low<=0;
                        note_num<=5'd14; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g_low<=1;
                        note_num<=5'd13; end
                end
                5'd14: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_g<=0;
                        note_num<=5'd15; end
                    else begin
    //                    r_sound<=sound_a;
                        en_g<=1;
                        note_num<=5'd14; end
                end
                5'd15: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_e<=0;
                        note_num<=5'd16; end
                    else begin
    //                    r_sound<=sound_a;
                        en_e<=1;
                        note_num<=5'd15; end
                end
                5'd16: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_c<=0;
                        note_num<=5'd17; end
                    else begin
    //                    r_sound<=sound_a;
                        en_c<=1;
                        note_num<=5'd16; end
                end
                5'd17: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_b<=0;
                        note_num<=5'd18; end
                    else begin
    //                    r_sound<=sound_a;
                        en_b<=1;
                        note_num<=5'd17; end
                end
                5'd18: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_a<=0;
                        note_num<=5'd19; end
                    else begin
    //                    r_sound<=sound_a;
                        en_a<=1;
                        note_num<=5'd18; end
                end
                5'd19: begin
                    if (half_beats==1) begin //when first note is complete
                        half_beats<=0;
                        en_f<=0;
                        note_num<=5'd20; end
                    else begin
    //                    r_sound<=sound_a;
                        en_f<=1;
                        note_num<=5'd19; end
                end
                5'd20: begin
                    if (half_beats==1) begin //when first note is complete
                        half_beats<=0;
                        en_f<=0;
                        note_num<=5'd21; end
                    else begin
    //                    r_sound<=sound_a;
                        en_f<=1;
                        note_num<=5'd20; end
                end
                5'd21: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_e<=0;
                        note_num<=5'd22; end
                    else begin
    //                    r_sound<=sound_a;
                        en_e<=1;
                        note_num<=5'd21; end
                end
                5'd22: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_c<=0;
                        note_num<=5'd23; end
                    else begin
    //                    r_sound<=sound_a;
                        en_c<=1;
                        note_num<=5'd22; end
                end
                5'd23: begin
                    if (half_beats==2) begin //when first note is complete
                        half_beats<=0;
                        en_d<=0;
                        note_num<=5'd24; end
                    else begin
    //                    r_sound<=sound_a;
                        en_d<=1;
                        note_num<=5'd23; end
                end
                5'd24: begin
                    if (half_beats==3) begin //when first note is complete
                        half_beats<=0;
                        en_c<=0;
                        note_num<=5'd0; end
                    else begin
    //                    r_sound<=sound_a;
                        en_c<=1;
                        note_num<=5'd24; end
                end
                default: begin
                    note_num<=0; 
                    half_beats<=0; end
                
            endcase
            
            //Counter of half-beats, (and) a pause generator:
            if (break==0 && timer==BREAK) begin //if we're at a break (and) we need to finish it
                timer<=0;
                break<=1; //break is done and we continue
                z_halfs<=0;
            end
            else begin 
                if (timer==BEAT/2) begin
                        half_beats<=half_beats+1;
                        timer<=0;
                        z_halfs<=1; end
                else begin
                    timer<=timer+1;
                    if (half_beats==0 && z_halfs==1) begin //do a break. timer==1 half_beats resets in the next clock tick in the case statment
                        break<=0;
                        z_halfs<=1; end  
                    else 
                        break<=1;
                    if(timer !=0) begin //make sure half_beats is not affected by noise/leaks, and the recharge is not on the same clock it might reset
                        case (half_beats)
                            0: half_beats<=0;
                            1: half_beats<=1;
                            2: half_beats<=2;
                            3: half_beats<=3;
                            4: half_beats<=4;
                        endcase
                    end
                end              
            end 
        end //if on  
        else begin
            break<=0;
            timer<=0;
            half_beats<=0;
            note_num<=0;
            z_halfs<=1;
        end
    end //always end
   
    
    assign sound= (break==0) ? 0:
           (note_num==2 ||note_num==8 || note_num==18) ? sound_a:
           (note_num==5 || note_num==17) ? sound_b:
           (note_num==4 || note_num==11 || note_num==16 || note_num==22 || note_num==24) ? sound_c:
           (note_num==10 || note_num==23) ? sound_d:
           (note_num==15 || note_num==21) ? sound_e:
           (note_num==19 || note_num==20) ? sound_f: 
           (note_num==9 || note_num==0 || note_num==1 || note_num==3 || 
                note_num==6 || note_num==7 || note_num==12 || note_num==13 ) ? sound_g_low: 
           (note_num==14) ? sound_g:
           0; 
           

endmodule
