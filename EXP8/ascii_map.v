module ascii_map #(
	parameter ROM_SIZE = 256,
	parameter BREAK_CODE = 'hf0,
	parameter CAPS_CODE = 'h58
)(
	input clk,
	input [7:0] ps2_data,
	input nextdata_n,

	output reg [7:0] ascii_data,
	output reg [7:0] last_code,
	output reg [7:0] count
); 
	// ROM Initialization
	reg [7:0] lwr_rom [ROM_SIZE-1:0];
	reg [7:0] caps_rom [ROM_SIZE-1:0];
	integer i;
	initial begin
		for(i = 0; i < 256; i = i + 1) begin
			lwr_rom[i] = 0; caps_rom[i] = 0;
		end
//		$readmemh("D:/intelFPGA_lite/18.0/DESIGN/kbd/lwr_ascii.txt", lwr_rom, 0, ROM_SIZE-1);
//		$readmemh("D:/intelFPGA_lite/18.0/DESIGN/kbd/caps_ascii.txt", caps_rom, 0, ROM_SIZE-1);
		$readmemh("lwr_ascii.txt", lwr_rom, 0, ROM_SIZE-1);
		$readmemh("caps_ascii.txt", caps_rom, 0, ROM_SIZE-1);
	end
	
	// Convert ps2 into ascii
	reg break_mode, caps, caps_pressing;
	initial begin
		break_mode = 0; caps = 0; caps_pressing = 0;
	end
	always @ (posedge clk) begin
		if (!ps2_data) ascii_data <= ascii_data;
		else if (break_mode) begin
			ascii_data <= ascii_data;	// nothing to do
			if (ps2_data == CAPS_CODE && !nextdata_n)
				caps_pressing <= 0;
		end else begin
			if (ps2_data == CAPS_CODE) begin
				if (!caps_pressing) begin
					caps <= ~caps;
					caps_pressing <= 1;
				end
			end else if (ps2_data != BREAK_CODE) begin
				if (caps)
					ascii_data <= caps_rom[ps2_data];
				else ascii_data <= lwr_rom[ps2_data];
			end else ascii_data <= ascii_data;
		end
		if (ps2_data && !nextdata_n)
			break_mode <= (ps2_data == BREAK_CODE);
		else break_mode <= break_mode;
	end
	
	// Record last available code
	initial last_code = 0;
	always @ (posedge clk)
		if (ps2_data) begin
			if (ps2_data != BREAK_CODE)
				last_code <= ps2_data;
			else last_code <= last_code;
		end else last_code <= last_code;
	
			
	// Total hits
	reg [ROM_SIZE-1:0] counting_list;
	reg count_break;
	initial begin
		counting_list = 0;
		count = 0; count_break = 0;
	end
	always @ (posedge clk) begin
		if (ps2_data) begin
			if (counting_list[ps2_data]) begin
				if (count_break && !nextdata_n)
					counting_list[ps2_data] <= 0;
				count <= count;
			end else if (ps2_data != BREAK_CODE) begin
				if (count >= 99)
					count <= 0;
				else count <= count + 1;
				counting_list[ps2_data] <= 1;
			end else count <= count;
		end else count <= count;
		if (ps2_data && !nextdata_n)
			count_break <= (ps2_data == BREAK_CODE);
		else count_break <= count_break;
	end

endmodule
