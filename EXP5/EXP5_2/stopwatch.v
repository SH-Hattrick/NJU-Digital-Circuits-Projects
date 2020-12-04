module stopwatch(
	input [1:0]mode,//when 10,set to stop watch mode 
	input clk,
	input start_pause,// 0->start,1->pause
	input clr,//1->clear to zero, while keep counting
	output reg[17:0]clock
);
//inner signal
reg [5:0]min;
reg [5:0]sec;
reg [5:0]msec;

//init
initial
begin
clock = 0; //秒表：min/sec/msec
min = 0;
sec = 0;
msec = 0;
end

//always module
always @ (posedge clk)
begin
	if(mode == 2'b10)
		if(clr == 1)
		begin
			min <= 0;
			sec <= 0;
			msec <= 0;//清零
		end
		else if(start_pause == 0)
		begin//正常时钟
			if(msec < 59)
				msec <= msec + 1;
			else begin
				msec <= 0;
				if(sec < 59)
					sec <= sec + 1;
				else begin
					sec <= 0;
					if(min < 23)
						min <= min + 1;
					else min <= 0;
				end
			end
		end
		else if(start_pause == 1)
		begin
			min <= min;
			sec <= sec;
			msec <= msec;//保持原数据
		end
	else begin
		min <= min;
		sec <= sec;
		msec <= msec;//保持原数据
	end
	//返回值
	clock <= {min,sec,msec};
end

endmodule 