`timescale 1ns / 1ps

module display_sel(num, dig, code);
	input [2:0]			num;		// 数码管编号：0~7
	input [14:0]		dig;
	output reg [4:0]	code;		// 7段数码管显示数值,最高位为小数点

	always @* begin
        case(num)
            3'd0: code = dig[4:0];
            3'd1: code = dig[9:5];
            3'd2: code = dig[14:10];
            // 只用到前三片
            // 3'd3: ;
            // 3'd4: ;
            // 3'd5: ;
            // 3'd6: ;
            // 3'd7: ;
            default: code = 5'h0;
        endcase
    end

endmodule
