`timescale 1ns / 1ps

module FSM_sim;
    reg clk, insert, cancel_flag;
    reg [1:0] coin_val, drink_op;
    wire hold_ind, drink_1_ind, drink_2_ind, drinktk_ind, charge_ind;
    wire [5:0] coin_sum;
    
    always #1 clk = ~clk;
    
    initial fork
        #5 coin_val = 2'b01;
        #10 insert = 1;
    join
    
    FSM(
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
