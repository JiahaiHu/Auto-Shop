`timescale 1ns / 1ps

module dig_dec(
	input				hold,
	input				clk,
	input [5:0]			coin_sum,	// 十进制数
	output reg [39:0] 	dig
);
	wire [7:0] bcd;

	initial begin
		dig = 0;
	end

	BCD _bcd(
		.binary(coin_sum[5:1]),
		.bcd(bcd)
	);

	always @(posedge clk) begin
		if (hold == 1) begin	// 占用
			if (coin_sum[0] == 1) begin
				dig[3:0] = 4'b0101;
			end
			else begin
				dig[3:0] = 4'b0000;
			end
			dig[13:10] = bcd[7:4];
			dig[8:5] = bcd[3:0];
			dig[4] = 0;
			dig[9] = 1;
			dig[14] = 0;
			dig[19:15] = 5'b11111;
			dig[24:20] = 5'b11111;
			dig[29:25] = 5'b11111;
			dig[34:30] = 5'b11111;
			dig[39:35] = 5'b11111;
		end
		else begin	// 未占用
			dig[14:0]  = 15'b11111_11111_11111;	// none
			dig[19:15] = 5'b01101;	// O
			dig[24:20] = 5'b01100;	// L
			dig[29:25] = 5'b01100;	// L
			dig[34:30] = 5'b01011;	// E
			dig[39:35] = 5'b01010;	// H
		end
	end

endmodule
