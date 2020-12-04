module FSM_bin
	(
		 input   clk, in, reset,
		 output reg out,
		 output reg [3:0] state
	);
	
	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3,
		  S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;
		  
	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0: out = 1'b0;
			S1: out = 1'b0;
			S2: out = 1'b0;
			S3: out = 1'b0;
			S4: out = 1'b1;
			S5: out = 1'b0;
			S6: out = 1'b0;
			S7: out = 1'b0;
			S8: out = 1'b1;
			default: out = 1'bx;
		endcase
	end
	
	// Determine the next state
	always @ (posedge clk) begin
		if (reset) state <= S0;
		else
			case (state)
				S0: if (in) state <= S5; else state <= S1;
				S1: if (in) state <= S5; else state <= S2;
				S2: if (in) state <= S5; else state <= S3;
				S3: if (in) state <= S5; else state <= S4;
				S4: if (in) state <= S5; else state <= S4;
				S5: if (in) state <= S6; else state <= S1;
				S6: if (in) state <= S7; else state <= S1;
				S7: if (in) state <= S8; else state <= S1;
				S8: if (in) state <= S8; else state <= S1;
			endcase
	end
endmodule
