`timescale 1ns / 1ps

module BCD(
	input			clk,
	input [4:0]		binary,	// 5位二进制数
	output [7:0] 	bcd     // 十位数[7:4],个位数[3:0]
);

	reg [2:0] count5 = 4;
	reg [7:0] ShiftReg = 0;

    always @(posedge clk) begin
        if (count5 == 0)
            count5 <= 5;
        else
            count5 <= count5 - 1;
    end

    always @(posedge clk) begin
        if(count5 >= 0 && count5 <= 4) begin	// for(i = 4; i >= 0; i = i - 1)
            // shift left
            ShiftReg = ShiftReg << 1;
            ShiftReg[0] = binary[count5];

            //adjust by add 3
            if(ShiftReg[7:4] > 4)
                ShiftReg[7:4] = ShiftReg[7:4] + 3;
            else
                ShiftReg[7:4] = ShiftReg[7:4];
        
            if(ShiftReg[3:0] > 4)
                ShiftReg[3:0] = ShiftReg[3:0] + 3;
            else
                ShiftReg[3:0] = ShiftReg[3:0];
        end
        else if (count5 == 5)
        	ShiftReg = 0;
        else
            ShiftReg = ShiftReg;
    end
    
    assign bcd = ShiftReg;

endmodule
