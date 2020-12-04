module alarm(
	input [1:0]mode,//when 11, set to alarm reset mode
	input clk,//when 1,alarm on
	input [17:0]cur_clock,
	input hourkey,
	input minkey,
	input en,//when 0,turn off
	input seckey,//adjust by pushbutton
	output reg [17:0]clock,
	output reg alarming
);
//inner signal
reg [5:0]hour;
reg [5:0]min;
reg [5:0]sec;
reg [9:0]count;
reg alarm_on;

//init
initial 
begin
hour = 0;
min = 0;
sec = 0;
clock = 0;
count = 0;
alarm_on = 0;
end

//always module
always @ (posedge clk)
begin
	if(count == 1000)
	begin
		count <= 0;
	end
	else if(en && alarm_on == 1)
		count <= count + 1;
	else count <= count;
 	
	if(mode == 2'b11) //重设时间
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
	end
	//返回值
	clock <= {hour,min,sec};
end

always @ (en)//alarming
begin
	if(en == 1 && cur_clock == clock)
	begin
		alarm_on <= 1;
	end
	else if(en == 0)
	begin
		alarm_on <= 0;
	end
	else alarm_on <= alarm_on;
	alarming = alarm_on;
end

endmodule 