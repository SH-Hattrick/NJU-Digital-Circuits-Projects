module Clock(
	output reg[6:0] HEX0_sec1, 
	output reg[6:0] HEX1_sec2, 
	output reg[6:0] HEX2_min1, 
	output reg[6:0] HEX3_min2, //使用时间表盘当作秒表
	output reg[6:0] HEX4_h1, 
	output reg[6:0] HEX5_h2, 
	output reg LEDR0_alarm,//LEDR[0]
	output LEDR1_clock,//LEDR[9],used to test clk
	output test,//LEDR[8],used to test second[0]
	output alarm,//LEDR[1],报警
	
	input clk,//
	input [1:0]mode,//SW[1:0]

	//按钮调整时间
	input key0_secadj,//SW[9]
	input key1_minadj,//SW[8]
	input key2_houradj,//SW[7]
	
	//秒表
	input s_p,//SW[5]
	input clr,//SW[6]
	
	//闹铃
	input off//SW[4],when 0,turn off the alarm
);
//module called
myclock myclock1(.mode(mode),.clk(clk_t),
.hourkey(key2_houradj),.minkey(key1_minadj),.seckey(key0_secadj),.clock(normal_clock));

stopwatch stopwatch1(.mode(mode),.clk(clk_sw),.start_pause(s_p),.clr(clr),.clock(sw_clock));

alarm alarm1(.mode(mode),.clk(clk_sw),.cur_clock(normal_clock),.clock(alarm_clock),.alarming(alarm),
.hourkey(key2_houradj),.minkey(key1_minadj),.seckey(key0_secadj),.en(off));

//inner signal
reg [17:0]clock;
wire [17:0]normal_clock;
wire [17:0]sw_clock;
wire [17:0]alarm_clock;
reg [17:0]normal_clock_reg;
reg [17:0]sw_clock_reg;
reg [17:0]alarm_clock_reg;
reg [25:0]count_clk;
reg [22:0]count_sw;
reg clk_t;
reg clk_sw;

//init
initial
begin
clock = 0;
normal_clock_reg = 0;
sw_clock_reg = 0;
alarm_clock_reg = 0;
count_clk = 0;
count_sw = 0;
clk_t = 0;
clk_sw = 0;
end

//assign module
assign LEDR1_clock = clk_t;
assign test = clock[0];

//分频器1，每秒
always @ (posedge clk)
begin
	if(count_clk == 25000000)
	begin
		clk_t <= ~clk_t;
		count_clk <= 0;
	end
	else count_clk <= count_clk + 1;
end

//分频器2,每微秒
always @ (posedge clk)
begin
	if(count_sw == 2500000)
	begin
		clk_sw <= ~clk_sw;
		count_sw <= 0;
	end
	else count_sw <= count_sw + 1;
end

//clock赋值,多路选择
always @ (mode)
begin
	normal_clock_reg = normal_clock;
	sw_clock_reg = sw_clock;
	alarm_clock_reg = alarm_clock;
	case(mode)
	2'b00: clock = normal_clock_reg;
	2'b01: clock = normal_clock_reg;
	2'b10: clock = sw_clock_reg;
	2'b11: clock = alarm_clock_reg;
	endcase
end

//display
always @ (clock)
begin
	//seconds
	case(clock[5:0])
		00: HEX0_sec1 = 7'b1000000; 01: HEX0_sec1 = 7'b1111001;  02: HEX0_sec1 = 7'b0100100;03: HEX0_sec1 = 7'b0110000;04: HEX0_sec1 = 7'b0011001;05: HEX0_sec1 = 7'b0010010;06: HEX0_sec1 = 7'b0000010;07: HEX0_sec1 = 7'b1111000;08: HEX0_sec1 = 7'b0000000;09: HEX0_sec1 = 7'b0010000;
		10: HEX0_sec1 = 7'b1000000; 11: HEX0_sec1 = 7'b1111001;  12: HEX0_sec1 = 7'b0100100;13: HEX0_sec1 = 7'b0110000;14: HEX0_sec1 = 7'b0011001;15: HEX0_sec1 = 7'b0010010;16: HEX0_sec1 = 7'b0000010;17: HEX0_sec1 = 7'b1111000;18: HEX0_sec1 = 7'b0000000;19: HEX0_sec1 = 7'b0010000;
		20: HEX0_sec1 = 7'b1000000; 21: HEX0_sec1 = 7'b1111001;  22: HEX0_sec1 = 7'b0100100;23: HEX0_sec1 = 7'b0110000;24: HEX0_sec1 = 7'b0011001;25: HEX0_sec1 = 7'b0010010;26: HEX0_sec1 = 7'b0000010;27: HEX0_sec1 = 7'b1111000;28: HEX0_sec1 = 7'b0000000;29: HEX0_sec1 = 7'b0010000;
		30: HEX0_sec1 = 7'b1000000; 31: HEX0_sec1 = 7'b1111001;  32: HEX0_sec1 = 7'b0100100;33: HEX0_sec1 = 7'b0110000;34: HEX0_sec1 = 7'b0011001;35: HEX0_sec1 = 7'b0010010;36: HEX0_sec1 = 7'b0000010;37: HEX0_sec1 = 7'b1111000;38: HEX0_sec1 = 7'b0000000;39: HEX0_sec1 = 7'b0010000;
		40: HEX0_sec1 = 7'b1000000; 41: HEX0_sec1 = 7'b1111001;  42: HEX0_sec1 = 7'b0100100;43: HEX0_sec1 = 7'b0110000;44: HEX0_sec1 = 7'b0011001;45: HEX0_sec1 = 7'b0010010;46: HEX0_sec1 = 7'b0000010;47: HEX0_sec1 = 7'b1111000;48: HEX0_sec1 = 7'b0000000;49: HEX0_sec1 = 7'b0010000;
		50: HEX0_sec1 = 7'b1000000; 51: HEX0_sec1 = 7'b1111001;  52: HEX0_sec1 = 7'b0100100;53: HEX0_sec1 = 7'b0110000;54: HEX0_sec1 = 7'b0011001;55: HEX0_sec1 = 7'b0010010;56: HEX0_sec1 = 7'b0000010;57: HEX0_sec1 = 7'b1111000;58: HEX0_sec1 = 7'b0000000;59: HEX0_sec1 = 7'b0010000;
	default: HEX0_sec1 = 7'b1111111;
	endcase
	
	case(clock[5:0])
		0: HEX1_sec2 = 7'b1000000;10: HEX1_sec2 = 7'b1111001;20: HEX1_sec2 = 7'b0100100;30: HEX1_sec2 = 7'b0110000;40: HEX1_sec2 = 7'b0011001;50: HEX1_sec2 = 7'b0010010;
		1: HEX1_sec2 = 7'b1000000;11: HEX1_sec2 = 7'b1111001;21: HEX1_sec2 = 7'b0100100;31: HEX1_sec2 = 7'b0110000;41: HEX1_sec2 = 7'b0011001;51: HEX1_sec2 = 7'b0010010;
		2: HEX1_sec2 = 7'b1000000;12: HEX1_sec2 = 7'b1111001;22: HEX1_sec2 = 7'b0100100;32: HEX1_sec2 = 7'b0110000;42: HEX1_sec2 = 7'b0011001;52: HEX1_sec2 = 7'b0010010;
		3: HEX1_sec2 = 7'b1000000;13: HEX1_sec2 = 7'b1111001;23: HEX1_sec2 = 7'b0100100;33: HEX1_sec2 = 7'b0110000;43: HEX1_sec2 = 7'b0011001;53: HEX1_sec2 = 7'b0010010;
		4: HEX1_sec2 = 7'b1000000;14: HEX1_sec2 = 7'b1111001;24: HEX1_sec2 = 7'b0100100;34: HEX1_sec2 = 7'b0110000;44: HEX1_sec2 = 7'b0011001;54: HEX1_sec2 = 7'b0010010;
		5: HEX1_sec2 = 7'b1000000;15: HEX1_sec2 = 7'b1111001;25: HEX1_sec2 = 7'b0100100;35: HEX1_sec2 = 7'b0110000;45: HEX1_sec2 = 7'b0011001;55: HEX1_sec2 = 7'b0010010;
		6: HEX1_sec2 = 7'b1000000;16: HEX1_sec2 = 7'b1111001;26: HEX1_sec2 = 7'b0100100;36: HEX1_sec2 = 7'b0110000;46: HEX1_sec2 = 7'b0011001;56: HEX1_sec2 = 7'b0010010;
		7: HEX1_sec2 = 7'b1000000;17: HEX1_sec2 = 7'b1111001;27: HEX1_sec2 = 7'b0100100;37: HEX1_sec2 = 7'b0110000;47: HEX1_sec2 = 7'b0011001;57: HEX1_sec2 = 7'b0010010;
		8: HEX1_sec2 = 7'b1000000;18: HEX1_sec2 = 7'b1111001;28: HEX1_sec2 = 7'b0100100;38: HEX1_sec2 = 7'b0110000;48: HEX1_sec2 = 7'b0011001;58: HEX1_sec2 = 7'b0010010;
		9: HEX1_sec2 = 7'b1000000;19: HEX1_sec2 = 7'b1111001;29: HEX1_sec2 = 7'b0100100;39: HEX1_sec2 = 7'b0110000;49: HEX1_sec2 = 7'b0011001;59: HEX1_sec2 = 7'b0010010;
	default: HEX1_sec2 = 7'b1111111;
	endcase
	
	//minutes
	case(clock[11:6])
		00: HEX2_min1 = 7'b1000000;01: HEX2_min1 = 7'b1111001;02: HEX2_min1 = 7'b0100100;03: HEX2_min1 = 7'b0110000;04: HEX2_min1 = 7'b0011001;05: HEX2_min1 = 7'b0010010;06: HEX2_min1 = 7'b0000010;07: HEX2_min1 = 7'b1111000;08: HEX2_min1 = 7'b0000000;09: HEX2_min1 = 7'b0010000;
		10: HEX2_min1 = 7'b1000000;11: HEX2_min1 = 7'b1111001;12: HEX2_min1 = 7'b0100100;13: HEX2_min1 = 7'b0110000;14: HEX2_min1 = 7'b0011001;15: HEX2_min1 = 7'b0010010;16: HEX2_min1 = 7'b0000010;17: HEX2_min1 = 7'b1111000;18: HEX2_min1 = 7'b0000000;19: HEX2_min1 = 7'b0010000;
		20: HEX2_min1 = 7'b1000000;21: HEX2_min1 = 7'b1111001;22: HEX2_min1 = 7'b0100100;23: HEX2_min1 = 7'b0110000;24: HEX2_min1 = 7'b0011001;25: HEX2_min1 = 7'b0010010;26: HEX2_min1 = 7'b0000010;27: HEX2_min1 = 7'b1111000;28: HEX2_min1 = 7'b0000000;29: HEX2_min1 = 7'b0010000;
		30: HEX2_min1 = 7'b1000000;31: HEX2_min1 = 7'b1111001;32: HEX2_min1 = 7'b0100100;33: HEX2_min1 = 7'b0110000;34: HEX2_min1 = 7'b0011001;35: HEX2_min1 = 7'b0010010;36: HEX2_min1 = 7'b0000010;37: HEX2_min1 = 7'b1111000;38: HEX2_min1 = 7'b0000000;39: HEX2_min1 = 7'b0010000;
		40: HEX2_min1 = 7'b1000000;41: HEX2_min1 = 7'b1111001;42: HEX2_min1 = 7'b0100100;43: HEX2_min1 = 7'b0110000;44: HEX2_min1 = 7'b0011001;45: HEX2_min1 = 7'b0010010;46: HEX2_min1 = 7'b0000010;47: HEX2_min1 = 7'b1111000;48: HEX2_min1 = 7'b0000000;49: HEX2_min1 = 7'b0010000;
		50: HEX2_min1 = 7'b1000000;51: HEX2_min1 = 7'b1111001;52: HEX2_min1 = 7'b0100100;53: HEX2_min1 = 7'b0110000;54: HEX2_min1 = 7'b0011001;55: HEX2_min1 = 7'b0010010;56: HEX2_min1 = 7'b0000010;57: HEX2_min1 = 7'b1111000;58: HEX2_min1 = 7'b0000000;59: HEX2_min1 = 7'b0010000;
	default: HEX2_min1 = 7'b1111111;
	endcase
	
	case(clock[11:6])
		00: HEX3_min2 = 7'b1000000;10: HEX3_min2 = 7'b1111001;20: HEX3_min2 = 7'b0100100;30: HEX3_min2 = 7'b0110000;40: HEX3_min2 = 7'b0011001;50: HEX3_min2 = 7'b0010010;
		01: HEX3_min2 = 7'b1000000;11: HEX3_min2 = 7'b1111001;21: HEX3_min2 = 7'b0100100;31: HEX3_min2 = 7'b0110000;41: HEX3_min2 = 7'b0011001;51: HEX3_min2 = 7'b0010010;
		02: HEX3_min2 = 7'b1000000;12: HEX3_min2 = 7'b1111001;22: HEX3_min2 = 7'b0100100;32: HEX3_min2 = 7'b0110000;42: HEX3_min2 = 7'b0011001;52: HEX3_min2 = 7'b0010010;
		03: HEX3_min2 = 7'b1000000;13: HEX3_min2 = 7'b1111001;23: HEX3_min2 = 7'b0100100;33: HEX3_min2 = 7'b0110000;43: HEX3_min2 = 7'b0011001;53: HEX3_min2 = 7'b0010010;
		04: HEX3_min2 = 7'b1000000;14: HEX3_min2 = 7'b1111001;24: HEX3_min2 = 7'b0100100;34: HEX3_min2 = 7'b0110000;44: HEX3_min2 = 7'b0011001;54: HEX3_min2 = 7'b0010010;
		05: HEX3_min2 = 7'b1000000;15: HEX3_min2 = 7'b1111001;25: HEX3_min2 = 7'b0100100;35: HEX3_min2 = 7'b0110000;45: HEX3_min2 = 7'b0011001;55: HEX3_min2 = 7'b0010010;
		06: HEX3_min2 = 7'b1000000;16: HEX3_min2 = 7'b1111001;26: HEX3_min2 = 7'b0100100;36: HEX3_min2 = 7'b0110000;46: HEX3_min2 = 7'b0011001;56: HEX3_min2 = 7'b0010010;
		07: HEX3_min2 = 7'b1000000;17: HEX3_min2 = 7'b1111001;27: HEX3_min2 = 7'b0100100;37: HEX3_min2 = 7'b0110000;47: HEX3_min2 = 7'b0011001;57: HEX3_min2 = 7'b0010010;
		08: HEX3_min2 = 7'b1000000;18: HEX3_min2 = 7'b1111001;28: HEX3_min2 = 7'b0100100;38: HEX3_min2 = 7'b0110000;48: HEX3_min2 = 7'b0011001;58: HEX3_min2 = 7'b0010010;		
		09: HEX3_min2 = 7'b1000000;19: HEX3_min2 = 7'b1111001;29: HEX3_min2 = 7'b0100100;39: HEX3_min2 = 7'b0110000;49: HEX3_min2 = 7'b0011001;59: HEX3_min2 = 7'b0010010;
	default: HEX3_min2 = 7'b1111111;
	endcase
	
	//hours
	case(clock[17:12])
		00: HEX4_h1 = 7'b1000000;01: HEX4_h1 = 7'b1111001;02: HEX4_h1 = 7'b0100100;03: HEX4_h1 = 7'b0110000;04: HEX4_h1 = 7'b0011001;05: HEX4_h1 = 7'b0010010;06: HEX4_h1 = 7'b0000010;07: HEX4_h1 = 7'b1111000;08: HEX4_h1 = 7'b0000000;09: HEX4_h1 = 7'b0010000;
		10: HEX4_h1 = 7'b1000000;11: HEX4_h1 = 7'b1111001;12: HEX4_h1 = 7'b0100100;13: HEX4_h1 = 7'b0110000;14: HEX4_h1 = 7'b0011001;15: HEX4_h1 = 7'b0010010;16: HEX4_h1 = 7'b0000010;17: HEX4_h1 = 7'b1111000;18: HEX4_h1 = 7'b0000000;19: HEX4_h1 = 7'b0010000;
		20: HEX4_h1 = 7'b1000000;21: HEX4_h1 = 7'b1111001;22: HEX4_h1 = 7'b0100100;23: HEX4_h1 = 7'b0110000;
	default: HEX4_h1 = 7'b1111111;
	endcase
	
	if(clock[17:12] < 10)
		HEX5_h2 = 7'b1000000;
	else if(clock[16:12] < 20)
		HEX5_h2 = 7'b1111001;
	else if(clock[16:12] < 24)
		HEX5_h2 = 7'b0100100;
	else HEX5_h2 = 7'b1111111;
end

endmodule 