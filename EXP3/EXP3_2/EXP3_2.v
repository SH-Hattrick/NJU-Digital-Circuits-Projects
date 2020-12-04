
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module EXP3_2(

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output	reg     [9:0]		LEDR
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [3:0]later;



//=======================================================
//  Structural coding
//=======================================================
always @ (KEY)
begin
	LEDR[9:7] = KEY[2:0];
	case(KEY[2:0])
	3'b000:begin //加法
		later[3:0] = SW[7:4];
		{LEDR[4],LEDR[3:0]} = SW[3:0] + SW[7:4]; 
		LEDR[5] = (SW[3] == SW[7])&&(LEDR[3] != SW[3]);
		LEDR[6] = (LEDR[3:0] == 4'b0000)?1:0;
	end
	3'b001:begin //减法
		later[3:0] = ~SW[7:4] + 1;
		{LEDR[4],LEDR[3:0]} = SW[3:0] + later[3:0]; 
		LEDR[5] = (SW[3] == later[3])&&(LEDR[3] != SW[3]);
		LEDR[6] = (LEDR[3:0] == 4'b0000)?1:0;
	end
	3'b010:begin //取反
		LEDR[3:0] = ~SW[3:0];
	end
	3'b011:begin //与
		LEDR[3:0] = SW[3:0] & SW[7:4];
	end
	3'b100:begin //或
		LEDR[3:0] = SW[3:0] | SW[7:4];
	end
	3'b101:begin //异或
		LEDR[3:0] = SW[3:0] ^ SW[7:4];
	end
	3'b110:begin //比较大小
		if(SW[7]&&!SW[3])
			LEDR[0] = 1;
		else if(SW[3]&&!SW[7])
			LEDR[0] = 0;
		else if(SW[3]&&SW[7])
		begin
			LEDR[0] = (SW[6]&&!SW[2]) || ((SW[6]==SW[2])&&SW[5]&&!SW[1])
			|| ((SW[6]==SW[2])&&(SW[5]==SW[1])&&SW[4]&&!SW[0]);
		end
		else
		begin
			LEDR[0] = !((SW[6]&&!SW[2]) || ((SW[6]==SW[2])&&SW[5]&&!SW[1])
			|| ((SW[6]==SW[2])&&(SW[5]==SW[1])&&SW[4]&&!SW[0]) || (SW[3:0] == SW[7:4]));
		end
	end
	3'b111:begin //比较相等
		LEDR[0] = (SW[3:0] == SW[7:4])?1:0;
	end
	endcase
	
end
endmodule