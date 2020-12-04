module nextdata_ctrl # (
	parameter WAIT_TIME = 20
)(
	input clk,
	input ready,
	output reg next_ctrl
);
	reg [7:0] count;
	reg please_wait, in_waited, next_waited;
	initial begin
		count = 0; next_ctrl = 1;
		please_wait = 0; 
		in_waited = 0;
		next_waited = 0;
	end
	// Timer
	always @ (negedge clk) begin
		if (please_wait) begin
			if (count == 0) begin
				in_waited <= 0;
				next_waited <= 0;
				count <= count + 1;
			end else if (count == 25)  begin
				in_waited <= 1;
				count <= count + 1;
			end else if (count == 45) begin
				next_waited <= 1;
				count = 0;
			end else count <= count + 1;
		end else ;
	end
	// Controler
	always @ (negedge clk) begin
		if (next_waited) begin
			// reset
			please_wait <= 0;
			next_ctrl <= 1;
		end else if (in_waited) begin
			next_ctrl <= 0;
		end else ;
		if (ready) 
			please_wait <= 1;
	end


endmodule
