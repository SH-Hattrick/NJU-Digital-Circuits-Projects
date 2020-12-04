module Block(
	input clk,
	input in_data,
	input en,
	output reg out_1,
	output reg out_2
);
always @ (posedge clk )
if(en)
	begin
		out_1 = in_data;
		out_2 = out_1;
	end
else
	begin
		out_1 = out_1;
		out_2 = out_2;
	end
endmodule 