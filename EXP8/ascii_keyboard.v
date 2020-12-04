module ascii_keyboard # (
	parameter ROM_SIZE = 256,
	parameter DIGI_NUM = 6
)(
	// ps2_keyboard variables
	input clk,
	input clrn,
	input ps2_clk,
	input ps2_data,
	// digi_encdr variables
	output wire [7*DIGI_NUM-1:0] digi_output
);
	wire [7:0] data;
	wire [2:0] en_n;
	wire ready, overflow, next_ctrl;
	wire [23:0] result;
	
	reg [2:0] hex = 3'b011;
	
	nextdata_ctrl nctrl(
		// input
		.clk(clk),
		.ready(ready),
		// output
		.next_ctrl(next_ctrl)
	);
	
	ps2_keyboard i1 (  
		// input
		.clk(clk),
		.clrn(clrn),
		.nextdata_n(next_ctrl),
		.ps2_clk(ps2_clk),
		.ps2_data(ps2_data),
		// output
		.ready(ready),
		.overflow(overflow),
		.data(data)
	);
	ascii_map amap(
		// input 
		.clk(clk),
		.ps2_data(data),
		.nextdata_n(next_ctrl),
		// output
		.ascii_data(result[7:0]),
		.last_code(result[15:8]),
		.count(result[23:16])
	);
	
	digi_control dctrl(
		// input
		.clk(clk),
		.ps2_data(data),
		.nextdata_n(next_ctrl),
		// output
		.en_n(en_n)
	);
	
	genvar i;
	generate for(i = 0; i < 3; i = i + 1)
	begin: digi
		digi_encdr dencdr(
			// input
			.en_n(en_n[i]),
			.in_data(result[8*i + 7 : 8*i]),
			.hex(hex[i]),
			// output
			.digi(digi_output[14*i + 13 : 14*i])
		);
	end
	endgenerate
	

endmodule
