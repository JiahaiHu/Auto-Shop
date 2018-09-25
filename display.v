`timescale 1ns / 1ps

module seven_seg_display(
	input             clk100MHZ,
    input [14:0]      dig,
    output [7:0]      SEG,
    output [7:0]      AN
);
	wire		clk_N;
	wire [2:0]	num;
	wire [3:0]	data;

	divider #(5000) _divider(.clk(clk100MHZ), .clk_N(clk_N));

	counter _counter(.clk(clk_N), .out(num));

	decoder3_8 _d38(.num(num), .sel(AN));

	display_sel _ds(.num(num), .dig(dig), .code(data));	// 每片7段数码管显示对应数值data

	seven_seg_dec _ssd(.data(data), .segments(SEG));

endmodule
