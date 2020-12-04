module Register(
	input clk, //key[3]
	input [2:0]mode, //key[0],key[1],key[2]
	input [7:0]in_data, //SW[7:0]
	input onebit_data, //SW[8]
	output reg[7:0]out_data, //LEDR[7:0]
	output reg clk_led //SW[9]
);
//inner signal
reg clk_t;
reg [26:0]count_clk;

//initial
initial
begin
clk_t = 0;
count_clk = 0;
end

//移位寄存器
always @ (posedge clk)
begin
	clk_led <= clk_t;
	case(mode)
	3'b000:begin //清零
		out_data <= 0;
	end
	3'b001:begin //置数
		out_data <= in_data;
	end
	3'b010:begin //逻辑右移
		out_data <= {1'b0, out_data[7:1]};
	end
	3'b011:begin //逻辑左移
		out_data <= {out_data[6:0], 1'b0};
	end
	3'b100:begin //算术右移
		out_data <= {out_data[7], out_data[7:1]};
	end
	3'b101:begin //左端串行输入，并行输出8位
		out_data <= {onebit_data, out_data[7:1]};
	end
	3'b110:begin //循环右移
		out_data <= {out_data[0], out_data[7:1]};
	end
	3'b111:begin //循环左移
		out_data <= {out_data[6:0], out_data[7]};
	end
	endcase
end

endmodule 