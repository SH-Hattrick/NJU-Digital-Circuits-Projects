
module piano(
	input clk,
	input ps2_clk,
	input ps2_data,

	output reg[15:0] freq,
	output reg[6:0]volume,
	output reg[9:0]test,
	output reg en
);

reg [7:0] harmony [15:0];
reg [15:0] notes [23:0];
reg [3:0]write;
//reg add;
reg [17:0] sum;
reg break;
wire [7:0] data;
integer i;

//keyboard
ps2_keyboard k1(.clk(clk),.clrn(1),.ps2_clk(ps2_clk),
	.ps2_data(ps2_data),.data(data),.nextdata_n(0));


initial
begin
	write <= 0;
	freq <= 0;
	sum <= 0;
	break <= 0;
	volume <= 7'b1111000;
	$readmemh("note.txt",notes,0,23);
end


always @ (posedge clk)
begin
	test[4:0] <= freq[4:0];
	test[9:6] <= data[4:0];
	case(data)
			8'h15: begin freq /*harmony[write]*/ <= notes[0]; write = write + 1; end//C
			8'h1e: begin freq /*harmony[write]*/ <= notes[1]; write = write + 1; end//C#
			8'h1d: begin freq /*harmony[write]*/ <= notes[2]; write = write + 1; end//D
			8'h26: begin freq /*harmony[write]*/ <= notes[3]; write = write + 1; end//D#
			8'h24: begin freq /*harmony[write]*/ <= notes[4]; write = write + 1; end//E
			8'h2d: begin freq /*harmony[write]*/ <= notes[5]; write = write + 1; end//F
			8'h2e: begin freq /*harmony[write]*/ <= notes[6]; write = write + 1; end//F#
			8'h2c: begin freq /*harmony[write]*/ <= notes[7]; write = write + 1; end//G
			8'h36: begin freq /*harmony[write]*/ <= notes[8]; write = write + 1; end//G#
			8'h35: begin freq /*harmony[write]*/ <= notes[9]; write = write + 1; end//A
			8'h3D: begin freq /*harmony[write]*/ <= notes[10]; write = write + 1; end//A#
			8'h3c: begin freq /*harmony[write]*/ <= notes[11]; write = write + 1; end//B
			
			//high
			8'h2a: begin freq /*harmony[write]*/ <= notes[12]; write = write + 1; end//C
			8'h34: begin freq /*harmony[write]*/ <= notes[13]; write = write + 1; end//C#
			8'h32: begin freq /*harmony[write]*/ <= notes[14]; write = write + 1; end//D
			8'h33: begin freq /*harmony[write]*/ <= notes[15]; write = write + 1; end//D#
			8'h31: begin freq /*harmony[write]*/ <= notes[16]; write = write + 1; end//E
			8'h3a: begin freq /*harmony[write]*/ <= notes[17]; write = write + 1; end//F
			8'h42: begin freq /*harmony[write]*/ <= notes[18]; write = write + 1; end//F#
			8'h41: begin freq /*harmony[write]*/ <= notes[19]; write = write + 1; end//G
			8'h4b: begin freq /*harmony[write]*/ <= notes[20]; write = write + 1; end//G#
			8'h49: begin freq /*harmony[write]*/ <= notes[21]; write = write + 1; end//A
			8'h4c: begin freq /*harmony[write]*/ <= notes[22]; write = write + 1; end//A#
			8'h4a: begin freq /*harmony[write]*/ <= notes[23]; write = write + 1; end//B
			
			8'h55: begin						// +
				if (volume >= 7'b1111111)
					volume <= 7'b1111111;
				else volume <= volume + 1;
			end
			8'h4e: begin						// -
				if (volume <= 7'b0110000)
					volume <= 7'b0110000;
				else volume <= volume - 1;
			end
			default: freq <= freq;
	endcase
	
	if(data == 8'h55 || data == 8'h4e)
		en <= 1;
	else en <= 0;
	if (break && data != 0) begin
		freq <= 0;
		break <= 0;
	end
	if (data == 8'hf0) begin
		break <= 1;
		write = write - 1;
	end
end

always @ (clk)
begin
	test[5:0] = freq[5:0];
	test[9:6] = write[3:0];
	
	if(break && data != 0)
	begin
		freq <= 0;
		write <= write;
		break <= 0;
	end
	else if(write > 0 && data == harmony[write - 1])
	begin
		freq <= freq;
		write <= write;

	end

	else begin
		case(data)

			//low
			8'h15: begin /*freq*/ harmony[write] <= notes[0]; write <= write + 1; end//C
			8'h1e: begin /*freq*/ harmony[write] <= notes[1]; write <= write + 1; end//C#
			8'h1d: begin /*freq*/ harmony[write] <= notes[2]; write <= write + 1; end//D
			8'h26: begin /*freq*/ harmony[write] <= notes[3]; write <= write + 1; end//D#
			8'h24: begin /*freq*/ harmony[write] <= notes[4]; write <= write + 1; end//E
			8'h2d: begin /*freq*/ harmony[write] <= notes[5]; write <= write + 1; end//F
			8'h2e: begin /*freq*/ harmony[write] <= notes[6]; write <= write + 1; end//F#
			8'h2c: begin /*freq*/ harmony[write] <= notes[7]; write <= write + 1; end//G
			8'h36: begin /*freq*/ harmony[write] <= notes[8]; write <= write + 1; end//G#
			8'h35: begin /*freq*/ harmony[write] <= notes[9]; write <= write + 1;  end//A
			8'h3D: begin /*freq*/ harmony[write] <= notes[10]; write <= write + 1;  end//A#
			8'h3c: begin /*freq*/ harmony[write] <= notes[11]; write <= write + 1;  end//B
			
			//high
			8'h2a: begin /*freq*/ harmony[write] <= notes[12]; write <= write + 1;  end//C
			8'h34: begin /*freq*/ harmony[write] <= notes[13]; write <= write + 1;  end//C#
			8'h32: begin /*freq*/ harmony[write] <= notes[14]; write <= write + 1; end//D
			8'h33: begin /*freq*/ harmony[write] <= notes[15]; write <= write + 1;  end//D#
			8'h31: begin /*freq*/ harmony[write] <= notes[16]; write <= write + 1;  end//E
			8'h3a: begin /*freq*/ harmony[write] <= notes[17]; write <= write + 1;  end//F
			8'h42: begin /*freq*/ harmony[write] <= notes[18]; write <= write + 1; end//F#
			8'h41: begin /*freq*/ harmony[write] <= notes[19]; write <= write + 1; end//G
			8'h4b: begin /*freq*/ harmony[write] <= notes[20]; write <= write + 1; end//G#
			8'h49: begin /*freq*/ harmony[write] <= notes[21]; write <= write + 1;  end//A
			8'h4c: begin /*freq*/ harmony[write] <= notes[22]; write <= write + 1;  end//A#
			8'h4a: begin /*freq*/ harmony[write] <= notes[23]; write <= write + 1; end//B
		
		8'h55: begin						// +
			if (volume >= 7'b1111111)
				volume <= 7'b1111111;
			else volume <= volume + 1;
		end
		8'h4e: begin						// -
			if (volume <= 7'b0110000)
				volume <= 7'b0110000;
			else volume <= volume - 1;
		end
		endcase
		//f0
		if (break && data != 0) begin
			freq <= 0;
			break <= 0;
		end
		if (data == 8'hf0) begin
			if(write > 0)
				write <= write - 1;
			break <= 1;
		end
		//calculate frequency
		
		if(write == 0)
			freq <= 0;
		else begin 
			freq <= harmony[write - 1];
			
			for(i=0; i<write; i=i+1)
			begin
				sum <= sum + harmony[i];
			end
			sum /= (write+1);
		end
		
	end
end


endmodule 