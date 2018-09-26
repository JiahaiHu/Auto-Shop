`timescale 1ns / 1ps

module dig_dec(
	input				clk,
	input [5:0]			coin_sum,	// 十进制数
	output reg [14:0] 	dig
);
	wire [7:0] bcd;

	initial begin
		dig[4] = 0;
		dig[14] = 0;
		dig[3] = 0;
	end

	always @(posedge clk) begin
		if (coin_sum[0] == 1) begin
			dig[9] = 1;		// is odd
			dig[2:0] = 3'b101;
		end
		else begin
			dig[9] = 0;
			dig[2:0] = 3'b000;
		end
		dig[13:10] = bcd[7:4];
		dig[8:5] = bcd[3:0];
	end

	BCD _bcd(
		.clk(clk),
		.binary(coin_sum[5:1]),
		.bcd(bcd)
	);

endmodule
