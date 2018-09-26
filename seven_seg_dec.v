`timescale 1ns / 1ps

module seven_seg_dec(
	input [4:0]         data,
    output reg [7:0]    segments
);

	always @(data) begin
        case(data)
			                     // abc_defg_dp
            5'b00000: segments = 8'b000_0001_1; // 0
            5'b00001: segments = 8'b100_1111_1; // 1
            5'b00010: segments = 8'b001_0010_1; // 2
            5'b00011: segments = 8'b000_0110_1; // 3
            5'b00100: segments = 8'b100_1100_1; // 4
            5'b00101: segments = 8'b010_0100_1; // 5
            5'b00110: segments = 8'b010_0000_1; // 6
            5'b00111: segments = 8'b000_1111_1; // 7
            5'b01000: segments = 8'b000_0000_1; // 8
            5'b01001: segments = 8'b000_1100_1; // 9

            5'b10000: segments = 8'b000_0001_0; // 0.
            5'b10001: segments = 8'b100_1111_0; // 1.
            5'b10010: segments = 8'b001_0010_0; // 2.
            5'b10011: segments = 8'b000_0110_0; // 3.
            5'b10100: segments = 8'b100_1100_0; // 4.
            5'b10101: segments = 8'b010_0100_0; // 5.
            5'b10110: segments = 8'b010_0000_0; // 6.
            5'b10111: segments = 8'b000_1111_0; // 7.
            5'b11000: segments = 8'b000_0000_0; // 8.
            5'b11001: segments = 8'b000_1100_0; // 9.

            5'b01010: segments = 8'b100_1000_1; // H
            5'b01011: segments = 8'b011_0000_1; // E
            5'b01100: segments = 8'b111_0001_1; // L
            5'b01101: segments = 8'b000_0001_1; // O

            default:  segments = 8'b111_1111_1;
        endcase
    end

endmodule
