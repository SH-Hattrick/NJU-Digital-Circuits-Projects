module digi_control # (
	parameter CAPS_CODE = 'h58,
	parameter BREAK_CODE = 'hf0
)(
	input clk,
	input [7:0] ps2_data,
	input nextdata_n,
	output reg [2:0] en_n
);
	reg break_mode;
	initial begin
		break_mode = 0; en_n = 3'b111;
	end
	always @ (posedge clk) begin
		if (ps2_data) begin
			if (break_mode && !nextdata_n)
				en_n <= 3'b011;
			else if (ps2_data == CAPS_CODE)
				en_n <= 3'b001;
			else if (ps2_data == BREAK_CODE) 
				en_n <= en_n;
			else  en_n <= 0;
		end else en_n <= en_n;
		
		if (ps2_data && !nextdata_n)
			break_mode <= (ps2_data == BREAK_CODE);
		else break_mode <= break_mode;
	end

endmodule
