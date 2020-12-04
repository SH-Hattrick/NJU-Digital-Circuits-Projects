module myclock(
	input [1:0]mode,//when 00,set to ordinary clock mode;when 01,set to reset mode
	input clk,
	input hourkey,
	input minkey,
	input seckey,//adjust by pushbutton
	output reg[17:0]clock//时，分，秒
);
//在任何情况下计时器都应正常工作，除非在时间重设时，暂停计时
//inner signal
reg [5:0]hour;
reg [5:0]min;
reg [5:0]sec;

//init
initial 
begin
hour = 0;
min = 0;
sec = 0;
clock = 0;
end

//always module
always @ (posedge clk)
begin
	if(mode == 2'b01) //重设时间
	begin
		if(hourkey)
			if(hour < 23)
				hour <= hour + 1;
			else hour <= 0;
		else hour <= hour;
		
		if(minkey)
			if(min < 59)
				min <= min + 1;
			else begin
				min <= 0;
				if(hour < 23)
					hour <= hour + 1;
				else hour <= 0;
			end
		else min <= min;
			
		if(seckey)
			if(sec < 59)
				sec <= sec + 1;
			else begin
				sec <= 0;
				if(min < 59)
					min <= min + 1;
				else begin
					min <= 0;
					if(hour < 23)
						hour <= hour + 1;
				else hour <= 0;
				end
			end
		else sec <= sec;
	end //如何使重设时间不受clk控制？
	
	else begin//正常时钟

		if(sec < 59)
			sec <= sec + 1;
		else begin
			sec <= 0;
			if(min < 59)
				min <= min + 1;
			else begin
				min <= 0;
				if(hour < 23)
					hour <= hour + 1;
				else hour <= 0;
			end
		end
	end
	
	//返回值
	clock <= {hour,min,sec};
end
endmodule 