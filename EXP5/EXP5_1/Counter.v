module Counter(
	input clk,
	input s_p, // 开始或暂停,SW[1]
	input clr, //SW[0]
	output reg rco,
	output reg [3:0] units,
	output reg [3:0] tens,
	output reg [6:0] Hex0,
	output reg [6:0] Hex1
);
//inner signal
reg [26:0]clk_onesec;
reg clk_t;

//functions
function reg [13:0] to_hex;
input [3:0]ten;
input [3:0]unit;
reg [6:0] HEX1;
reg [6:0] HEX0;
begin
	case(unit)
	4'b0000: HEX0 = 7'b1000000;
	4'b0001: HEX0 = 7'b1111001;
	4'b0010: HEX0 = 7'b0100100;
	4'b0011: HEX0 = 7'b0110000;
	4'b0100: HEX0 = 7'b0011001;
	4'b0101: HEX0 = 7'b0010010;
	4'b0110: HEX0 = 7'b0000010;
	4'b0111: HEX0 = 7'b1111000;
	4'b1000: HEX0 = 7'b0000000;
	4'b1001:	HEX0 = 7'b0010000;
	default: HEX0 = 7'b1111111; 
	endcase
	
	case(ten)
	4'b0000: HEX1 = 7'b1000000;
	4'b0001: HEX1 = 7'b1111001;
	4'b0010: HEX1 = 7'b0100100;
	4'b0011: HEX1 = 7'b0110000;
	4'b0100: HEX1 = 7'b0011001;
	4'b0101: HEX1 = 7'b0010010;
	4'b0110: HEX1 = 7'b0000010;
	4'b0111: HEX1 = 7'b1111000;
	4'b1000: HEX1 = 7'b0000000;
	4'b1001:	HEX1 = 7'b0010000;
	default: HEX1 = 7'b1111111; 
	endcase
	
	to_hex = {HEX1, HEX0};
end
endfunction
//init
initial 
begin
	clk_onesec = 0;
	clk_t = 0;
	units = 0;
	tens = 0;
end

//always module
always @ (posedge clk)
begin
	if(clk_onesec == 25000000)
	begin
		clk_t <= ~clk_t;
		clk_onesec <= 0;
	end
	else clk_onesec <= clk_onesec + 1;
end

always @ (posedge clk_t)
begin
	if(clr) // 清零状态
	begin
		rco <= 0;
		units <= 0;
		tens <= 0;
	end
	else if(!s_p)
	begin
		rco <= rco;
		units <= units;
		tens <= tens;
	end
	else begin
		if(units == 9 && tens == 9)
		begin
			units <= 0;
			tens <= 0;
			rco <= 1;
		end
		else if(units == 9)
		begin
			rco <= 0;
			tens <= tens + 1;
			units <= 0;
		end
		else begin
			rco <= 0;
			units <= units + 1;
			tens <= tens;
		end
	end
	{Hex1,Hex0} = to_hex(tens, units); 
end
endmodule 