`timescale 1ns / 1ps

module BCD(
	input [4:0]		   binary,	// 5位二进制数
	output reg [7:0]   bcd      // 十位数[7:4],个位数[3:0]
);

    initial begin
        bcd = 0;
    end

    always @(binary) begin
        bcd[3:0] = binary % 4'b1010;
        bcd[7:4] = binary / 4'b1010;
    end

endmodule
