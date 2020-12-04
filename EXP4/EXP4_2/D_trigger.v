module D_trigger(
	input en,
	input clk,//SW[3]
	input clr,
	input in_data,
	output out_sy,
	output out_asy //清零：SW[2],使能，SW[1]，数据SW[0]
);

asyclr asy(.en(en), .clk(clk), .clr(clr), .in_data(in_data), .out_asy(out_asy));
syclr sy(.en(en), .clk(clk), .clr(clr), .in_data(in_data), .out_sy(out_sy));


endmodule 