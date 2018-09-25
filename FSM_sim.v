`timescale 1ns / 1ps

module FSM_sim;
    reg clk, insert, cancel_flag;
    reg [1:0] coin_val, drink_op;
    wire hold_ind, drink_1_ind, drink_2_ind, drinktk_ind, charge_ind;
    wire [5:0] coin_sum;

    initial begin
        insert = 0;
        cancel_flag = 0;
        coin_val = 0;
        drink_op = 0;

        clk = 0;
        forever #20 clk = ~clk;
    end
    
    initial begin
        // test s1
        // insert 1
        #10 coin_val = 2'b01;
        insert = 1;
        #20 coin_val = 2'b00;
        insert = 0;
        // cancel
        #20 cancel_flag = 1;
        #20 cancel_flag = 0;

        // test s2
        // insert 1 for 3 times
        #60 coin_val = 2'b01;
        insert = 1;
        #100 coin_val = 2'b00;
        insert = 0;
        // choose drink 1
        #20 drink_op = 1 ;
        #20 drink_op = 0 ;
        // cancel
        // #20 cancel_flag = 1;
        // #20 cancel_flag = 0;

        // test s3
        // insert 10
        #60 coin_val = 2'b10;
        insert = 1;
        #20 coin_val = 2'b00;
        insert = 0;
        // choose drink 2
        #20 drink_op = 2;
        #20 drink_op = 0;
        // cancel
        // #20 cancel_flag = 1;
        // #20 cancel_flag = 0;

        // test
        // insert 1 for 5 times
        #60 coin_val = 2'b01;
        insert = 1;
        #180 coin_val = 2'b00;
        insert = 0;
        // choose drink 2
        #20 drink_op = 2;
        #20 drink_op = 2;
    end
    
    FSM test(
        clk,            // 时钟脉冲信号
        insert,         // 投币脉冲信号
        coin_val,       // 硬币类型
        drink_op,       // 饮料种类
        cancel_flag,    // 取消脉冲信号
        hold_ind,       // 占用指示
        drink_1_ind,    // 饮料1(2.5元)可购买指示
        drink_2_ind,    // 饮料2(5元)可购买指示
        drinktk_ind,    // 取饮料指示
        charge_ind,     // 取零钱或退币指示
        coin_sum        // 投币总值或退币总值(Q1型定点小数:q=x*2)
    );

endmodule
