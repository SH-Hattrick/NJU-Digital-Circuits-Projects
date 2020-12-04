module piture_control(
    input clk,
	 output VGA_CLK,
	input [7:0]ascii, 
	output reg [11:0]preindex,
	//output reg [3:0] cnt,
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);

wire [9:0]h_addr;
wire [9:0]v_addr;
wire hsync;
wire vsync;
wire valid;
wire [23:0]vga;
assign VGA_SYNC_N = 1'b0;
assign VGA_R = vga[23:16];
assign VGA_G = vga[15:8];
assign VGA_B = vga[7:0];
assign VGA_HS = hsync;
assign VGA_VS = vsync;
assign VGA_BLANK_N = valid;
reg [23:0]data = 24'hffffff;
wire [8:0]font;
reg [11:0]address;
reg [11:0]block_addr = 0;
reg [7:0] ascii_data;
//reg [11:0]index = 12'hfff;
reg [11:0]index = 0;
reg flag =1'b1;
wire [7:0]ram_vga_ret;
wire clk_vga;
wire clk_keyboard;
assign VGA_CLK = clk_vga;
wire [7:0]now_ascii;
reg backspace_state = 1;
reg enter_state = 1;
reg [11:0]ram_index[29:0];
//reg [11:0]preindex;
reg [3:0]cnt = 0;
//reg [7:0]preascii;
clkgen #25000000 c(clk,1'b0,1'b1,clk_vga);
clkgen #20 c2(clk,1'b0,1'b1,clk_keyboard);

vga_ctrl v_C(clk_vga,1'b0,data,h_addr,v_addr,hsync,vsync,valid,vga[23:16],vga[15:8],vga[7:0]);
rom_font rf(.address(address),.clock(clk_vga),.q(font));
//ram_vga rv(block_addr,index_input,clk_vga,clk_keyboard,1'b0,ascii_data,1'b0,1'b1,ram_vga_ret,temp);
ram_vga rv(block_addr,index,clk_vga,clk_keyboard,1'b0,ascii_data,1'b0,1'b1,ram_vga_ret,now_ascii);



always @(clk_keyboard)begin
	if(index < 12'd70)begin
		preindex <= 0;
	end
	else begin
		preindex <= ram_index[(index/70)-1];
	end
end



always @(clk_vga)begin
    block_addr <= (v_addr >> 4) * 70 + ((h_addr) / 9);
	 address <= (ram_vga_ret << 4) + (v_addr % 16);
	 if(font[(h_addr + 5) % 9] == 1'b1)
		data <= 24'hffffff;
	 else
		data <= 24'h000000;
end	

always @(posedge clk_keyboard) begin
    if(ascii != 0) 
		begin
			if(cnt == 0 )
			begin
				if(ascii == 8'h0d)begin//hit enter
					 backspace_state <= 0;
					 ram_index[index/70] <= index + 1;
                index <= index + 70 - (index % 70);
					 enter_state <= 0;
				end
				else if (ascii == 8'h08 ) begin//hit backspace
						if(backspace_state == 0)begin
							index <= index;
							backspace_state <= 1'b1;
						end
						else begin
							if(index % 70 == 0)begin
								index <= preindex;
							end
							else begin
								index <= index - 1;
							end
						end
					 end
				else begin//hit key
					 if(backspace_state == 1 || enter_state == 0)
						index <= index;
					 else begin
						if((index + 1) % 70 == 0)begin
							ram_index[(index-1)/70] <= index;
						end
						index <= index + 1;

					 end
					 backspace_state <= 0;
					 enter_state <= 1;
				end
				cnt <= cnt + 1;
			end
			else if(cnt == 4'd12)begin
						if(ascii == 8'h0d) 
							index <= index + 70 - (index % 70) - 1;
						else if (ascii == 8'h08)begin
							if(index % 70 == 0)begin
								index <= preindex;
							end
							else begin
								index <= index - 1;
							end
						end
					else begin
						if((index + 1) % 70 == 0)begin
							ram_index[(index-1)/70] <= index;
						end							
							index <= index + 1;
						end
					end
			else begin
				index <= index;
				cnt <= cnt + 1;
			end
			ascii_data <= ascii;
		end
	
    else begin		  
        index <= index;
		  cnt <= 0;
	 end

	if(index >= 2100) 
        index <= 0;
end

endmodule // piture_control
