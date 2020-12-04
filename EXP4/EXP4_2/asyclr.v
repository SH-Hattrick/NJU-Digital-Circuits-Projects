module asyclr(
	input en,
	input clk, 
	input clr,
	input in_data,
	output reg out_asy
);
always @ (posedge clk or posedge clr)
begin
	if(clr)
		if(en)
			out_asy <= 0;
		else out_asy <= out_asy;
	else
	begin
		if(en)
			out_asy <= in_data;
		else out_asy <= out_asy;
	end
end
	
endmodule 