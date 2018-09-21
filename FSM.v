`timescale 1ns / 1ps

module FSM(
    input               clk,            // 时钟脉冲信号
    input               insert,         // 投币脉冲信号
    input [1:0]         coin_val,       // 硬币类型
    input [1:0]         drink_op,       // 饮料种类
    input               cancel_flag,    // 取消脉冲信号
    output reg          hold_ind,       // 占用指示
    output reg          drink_1_ind,    // 饮料1(2.5元)可购买指示
    output reg          drink_2_ind,    // 饮料2(5元)可购买指示
    output reg          drinktk_ind,    // 取饮料指示
    output reg          charge_ind,     // 取零钱或退币指示
    output reg [5:0]    coin_sum        // 投币总值或退币总值(Q1型定点小数:q=x*2)
    );
    
    parameter DRINK_1 = 5,
                DRINK_2 = 10,
                SUM_MAX = 40;

    parameter s0 = 3'b000,
              s1 = 3'b001,
              s2 = 3'b010,
              s3 = 3'b011,
              s4 = 3'b100;
    
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        case (state)
            s0:
                begin
                    // ...
                end

    end

    always @(posedge insert) begin
    
    end

endmodule
