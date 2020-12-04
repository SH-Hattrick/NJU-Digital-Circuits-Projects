module digi_encdr(en_n, in_data, hex, digi);
	input en_n;
	input [7:0] in_data;
	input hex;
	output reg [13:0] digi;
	
	wire [7:0] data_BCD16;
	
	num2BCD16 n1(
		.num(in_data),
		.hex(hex),
		.bcd(data_BCD16)
	);
	
	genvar i;
	generate for(i = 0; i < 2; i = i + 1)
	begin: bite
		always @ (en_n or data_BCD16) begin
			if (en_n) begin
				digi[7*i + 6: 7*i] = 7'b1111111;		// light off
			end else begin
				case(data_BCD16[4*i + 3 : 4*i])
					4'b0000: digi[7*i + 6: 7*i] = 7'b1000000; // 0
					4'b0001: digi[7*i + 6: 7*i] = 7'b1111001; // 1
					4'b0010: digi[7*i + 6: 7*i] = 7'b0100100; // 2
					4'b0011: digi[7*i + 6: 7*i] = 7'b0110000; // 3
					4'b0100: digi[7*i + 6: 7*i] = 7'b0011001; // 4
					4'b0101: digi[7*i + 6: 7*i] = 7'b0010010; // 5
					4'b0110: digi[7*i + 6: 7*i] = 7'b0000010; // 6
					4'b0111: digi[7*i + 6: 7*i] = 7'b1011000; // 7
					4'b1000: digi[7*i + 6: 7*i] = 7'b0000000; // 8
					4'b1001: digi[7*i + 6: 7*i] = 7'b0011000; // 9
					4'b1010: digi[7*i + 6: 7*i] = 7'b0001000; // A
					4'b1011: digi[7*i + 6: 7*i] = 7'b0000011; // B
					4'b1100: digi[7*i + 6: 7*i] = 7'b1000110; // C
					4'b1101: digi[7*i + 6: 7*i] = 7'b0100001; // D
					4'b1110: digi[7*i + 6: 7*i] = 7'b0000110; // E
					4'b1111: digi[7*i + 6: 7*i] = 7'b0001110; // F
					default: digi[7*i + 6: 7*i] = 7'b1111111;
				endcase
			end
		end
	end
	endgenerate
	
	
endmodule 