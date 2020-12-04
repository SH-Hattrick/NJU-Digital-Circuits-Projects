module elec_piano(
	input clk,
	input ps2_clk,
	input ps2_data,
	output reg [15:0] freq,
	output reg [6:0] volume
);

wire [7:0] data;

reg [15:0] eight_note [7:0];

reg break;

ps2_keyboard pk(
	.clk(clk),
	.clrn(1),
	.ps2_clk(ps2_clk),
	.ps2_data(ps2_data),
	.nextdata_n(0),
	.data(data)
);


initial begin
	freq <= 0; volume <= 7'h7f; break <= 0;
	$readmemh("note_init.txt", eight_note, 0,  7);
end

always @ (posedge clk) begin
	case(data)
		8'h16: freq <= eight_note[0];	// 1
		8'h1e: freq <= eight_note[1];	// 2
		8'h26: freq <= eight_note[2];	// 3
		8'h25: freq <= eight_note[3];	// 4
		8'h2e: freq <= eight_note[4];	// 5
		8'h36: freq <= eight_note[5];	// 6
		8'h3d: freq <= eight_note[6];	// 7
		8'h3e: freq <= eight_note[7];	// 8
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
		default: freq <= freq;			// others
	endcase

	if (break && data != 0) begin
		freq <= 0;
		break <= 0;
	end
	if (data == 8'hf0) begin
		break <= 1;
	end
end


endmodule 