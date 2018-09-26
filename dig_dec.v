`timescale 1ns / 1ps

module dig_dec(
	input				clk,
	input [5:0]			coin_sum,	// 十进制数
	output reg [14:0] 	dig
);
	wire [7:0] bcd;

	initial begin
		dig = 0;
		dig[9] = 1;
	end

	BCD _bcd(
		.binary(coin_sum[5:1]),
		.bcd(bcd)
	);

	always @(posedge clk) begin
		if (coin_sum[0] == 1) begin
			dig[3:0] = 4'b0101;
		end
		else begin
			dig[3:0] = 4'b0000;
		end
		dig[13:10] = bcd[7:4];
		dig[8:5] = bcd[3:0];
	end

endmodule
