module EXP4_1(
	input clk,
	input in_data,
	input en,
	output out_u1,
	output out_u2,
	output out_1,
	output out_2
);
Block b1(.clk(clk), .in_data(in_data), .en(en), .out_1(out_1), .out_2(out_2));
UnBlock ub1(.clk(clk), .in_data(in_data), .en(en), .out_1(out_u1), .out_2(out_u2));


endmodule 