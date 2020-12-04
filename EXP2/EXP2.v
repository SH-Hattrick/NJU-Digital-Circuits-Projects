
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module EXP2(

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		reg     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		reg     [6:0]		HEX0
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================
always @ (SW)
	begin
		casex(SW)
		10'bxx1xxxxxxx: begin LEDR = 10'd7; HEX0 = 7'b1111000; end
		10'bxx01xxxxxx: begin LEDR = 10'd6; HEX0 = 7'b0000010; end 
		10'bxx001xxxxx: begin LEDR = 10'd5; HEX0 = 7'b0010010; end
		10'bxx0001xxxx: begin LEDR = 10'd4; HEX0 = 7'b0011001; end
		10'bxx00001xxx: begin LEDR = 10'd3; HEX0 = 7'b0110000; end
		10'bxx000001xx: begin LEDR = 10'd2; HEX0 = 7'b0100100; end 
		10'bxx0000001x: begin LEDR = 10'd1; HEX0 = 7'b1111001; end
		10'bxx00000001: begin LEDR = 10'd0; HEX0 = 7'b1000000; end
		default: begin LEDR = 10'd0; HEX0 = 7'b1111111; end
		endcase
	end	


endmodule
