module RandomNum(
	input s_p,
	input clk,
	output reg [7:0] randnum,
	output reg [6:0] HEX0,
	output reg [6:0] HEX1
);
//inner signal
reg tmp;
//init
initial
begin
randnum = 0;
tmp = 0;
end

//always module
always @ (clk)
begin
	if(s_p)//生成随机数中
	begin
		if(randnum == 0)
		begin
			randnum <= 10;
		end
		tmp <= randnum[4] ^ randnum[3] ^ randnum[2] ^ randnum[0];
		randnum <= {tmp, randnum[7:1]};//待优化的式子
	end
	else
	begin
		randnum <= randnum;
		tmp <= tmp;
	end
end

//display
always @ (clk)
begin
	case(randnum[3:0])
	0: HEX0 = 7'b1000000;
	1:	HEX0 = 7'b1111001;
	2: HEX0 = 7'b0100100;
	3: HEX0 = 7'b0110000;
	4: HEX0 = 7'b0011001;
	5: HEX0 = 7'b0010010;
	6: HEX0 = 7'b0000010;
	7: HEX0 = 7'b1111000;
	8: HEX0 = 7'b0000000;
	9: HEX0 = 7'b0010000;
	10: HEX0 = 7'b0001000;
	11: HEX0 = 7'b0000011;
	12: HEX0 = 7'b10000110;
	13: HEX0 = 7'b0100001;
	14: HEX0 = 7'b0000110;
	15: HEX0 = 7'b0001110;
	default: HEX0 = 7'b1111111;
	endcase
	
	case(randnum[7:4])
	0: HEX1 = 7'b1000000;
	1:	HEX1 = 7'b1111001;
	2: HEX1 = 7'b0100100;
	3: HEX1 = 7'b0110000;
	4: HEX1 = 7'b0011001;
	5: HEX1 = 7'b0010010;
	6: HEX1 = 7'b0000010;
	7: HEX1 = 7'b1111000;
	8: HEX1 = 7'b0000000;
	9: HEX1 = 7'b0010000;
	10: HEX1 = 7'b0001000;
	11: HEX1 = 7'b0000011;
	12: HEX1 = 7'b10000110;
	13: HEX1 = 7'b0100001;
	14: HEX1 = 7'b0000110;
	15: HEX1 = 7'b0001110;
	default: HEX0 = 7'b1111111;
	endcase
end


endmodule 