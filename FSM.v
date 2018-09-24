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
    // reg operator;   // plus:1, minus:0

    initial begin
        hold_ind = 0;
        drink_1_ind = 0;
        drink_2_ind = 0;
        drinktk_ind = 0;
        charge_ind = 0;
        coin_sum = 0;
        state = 0;
        next_state = 0;
    end

    // 投币总值控制
    always @(posedge clk) begin
        if (insert == 1) begin
            // insert
            if (coin_val == 2'b01)
                if (coin_sum + 1 * 2 < SUM_MAX)
                    coin_sum = coin_sum + 1 * 2;
            else if (coin_val == 2'b10)
                if (coin_sum + 10 * 2 < SUM_MAX)
                    coin_sum = coin_sum + 10 * 2;
        end
        else begin
            // charge
            case (state)
                s2:
                    if (drink_op == 1)
                        coin_sum = coin_sum - 5;
                s3:
                    begin
                        if (drink_op == 1)
                            coin_sum = coin_sum - 5;
                        else if (drink_op == 2)
                            coin_sum = coin_sum - 10;
                    end
                s4:
                    coin_sum = 0;   // 归零
                default :
                    coin_sum = coin_sum;
            endcase
        end
    end


    // 状态管理
    always @(posedge clk) begin
        case (state)
            s0:
                begin
                    if (coin_sum > 0) begin
                        if (coin_sum < 5)
                            next_state = s1;
                        else if (coin_sum <= 40)
                            next_state = s3;
                    else
                        next_state = s0;
                    end
                end
            s1:
                begin
                    if (cancel_flag == 1)
                        next_state = s4;
                    else if (coin_sum >= 5) begin
                        if (coin_sum < 10)
                            next_state = s2;
                        else if (coin_sum <= 40)
                            next_state = s3;
                    end
                    else
                        next_state = s1;
                end
            s2:
                begin
                    if (cancel_flag == 1)
                        next_state = s4;
                    else if (drink_op == 1)
                        next_state = s4;
                    else if (coin_sum >= 10)
                        next_state = s3;
                    else
                        next_state = s2;
                end
            s3:
                begin
                    if (cancel_flag == 1)
                        next_state = s4;
                    else if (drink_op == 1)
                        next_state = s4;
                    else if (drink_op == 2)
                        next_state = s4;
                    else
                        next_state = s3;
                end
            s4:
                begin
                    next_state = s0;
                end
            default:
                next_state = s0;
        endcase
        state = next_state;
    end

    // 输出控制
    always @(posedge clk) begin
        case (state)
            s0:
                begin
                    hold_ind = 0;
                    drink_1_ind = 0;
                    drink_2_ind = 0;
                    drinktk_ind = 0;
                    charge_ind = 0;
                end
            s1:
                begin
                    hold_ind = 1;
                    drink_1_ind = 0;
                    drink_2_ind = 0;
                    drinktk_ind = 0;
                    charge_ind = 0;
                end
            s2:
                begin
                    hold_ind = 1;
                    drink_1_ind = 1;
                    drink_2_ind = 0;
                    drinktk_ind = 0;
                    charge_ind = 0;
                end
            s3:
                begin
                    hold_ind = 1;
                    drink_1_ind = 1;
                    drink_2_ind = 0;
                    if (drink_op == 1)  // 选择第一种饮料
                        drinktk_ind = 1;
                    else if (drink_op == 2)  // 选择第二种饮料
                        drinktk_ind = 1;
                    else
                        drinktk_ind = 0;
                    if (coin_sum > 0)
                        charge_ind = 1;
                    else
                        charge_ind = 0;
                end
            s4:
                begin
                    drink_1_ind = 0;
                    drink_2_ind = 0;

                    if (cancel_flag == 1)
                        charge_ind = 1;
                    else if (drink_op == 1 && coin_sum > 0)
                        charge_ind = 1;
                    else if (drink_op == 2 && coin_sum > 0)
                        charge_ind = 1;
                    else
                        charge_ind = 0;

                    if (drink_op == 1)
                        drinktk_ind = 1;
                    else if (drink_op == 2)
                        drinktk_ind = 1;
                    else
                        drinktk_ind = 0;
                end
            default : /* default */;
        endcase
    end

endmodule
