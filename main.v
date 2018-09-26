`timescale 1ns / 1ps

module main(
    input			clk100MHZ,
    input			insert,
	input [1:0]     coin_val,
    input [1:0]     drink_op,
    input           cancel_flag,
	output			hold_ind,
    output			drink_1_ind,
    output			drink_2_ind,
    output			drinktk_ind,
    output			charge_ind,
    output [7:0]    AN,
    output [7:0]    SEG,
    output          clk_1HZ
);
    wire [39:0]     dig;
    wire [5:0]		coin_sum;

    divider _1HZ(.clk(clk100MHZ), .clk_N(clk_1HZ));

    FSM _FSM(
        .clk(clk_1HZ),
        .insert(insert),
        .coin_val(coin_val),
        .drink_op(drink_op),
        .cancel_flag(cancel_flag),
        .hold_ind(hold_ind),
        .drink_1_ind(drink_1_ind),
        .drink_2_ind(drink_2_ind),
        .drinktk_ind(drinktk_ind),
        .charge_ind(charge_ind),
        .coin_sum(coin_sum)
    );

    dig_dec _dd(
        .clk(clk100MHZ),
    	.coin_sum(coin_sum),
    	.dig(dig)
    );

    seven_seg_display _dis(
        .clk100MHZ(clk100MHZ),
        .dig(dig),
        .SEG(SEG),
        .AN(AN)
    );


endmodule
