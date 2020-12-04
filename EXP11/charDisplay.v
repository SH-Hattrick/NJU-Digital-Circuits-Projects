module charDisplay(
   input clk,
	output VGA_CLK,
	input [7:0]ascii, 
	output reg [11:0]preindex,

	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);
//test
//wire hsync; //n
//wire vsync; //n
//wire valid; //n
//wire [23:0]vga; //n
//wire clk_vga;

//VGA display parameters
wire [9:0]h_addr;
wire [9:0]v_addr;
reg [23:0]data = 24'hffffff;
wire KB_CLK;
wire [8:0]font;
reg [11:0]address; // matrix addr

//addr
reg [11:0]block_addr = 0; // when read, as addr
reg [11:0]index = 0; // when write, as addr
reg [7:0] ascii_data; // when write, as data input
wire [7:0]ram_vga_ret; // when read, as data output
wire [7:0] out_useless; // 

//ext
reg [3:0]cnt = 0; 
reg backspace_state = 1; 
reg enter_state = 1; 
reg [11:0]ram_index[29:0];
//assign module
// to test time sequence
//assign VGA_SYNC_N = 1'b0;
//assign VGA_R = vga[23:16];
//assign VGA_G = vga[15:8];
//assign VGA_B = vga[7:0];
//assign VGA_HS = hsync;
//assign VGA_VS = vsync;
//assign VGA_BLANK_N = valid;
//assign VGA_CLK = clk_vga;


//call test
//clkgen #25000000 c1(clk,1'b0,1'b1,VGA_CLK);
//clkgen #20 c2(clk,1'b0,1'b1,KB_CLK);
////clkgen #25000000 c1(clk,1'b0,1'b1,clk_vga);
//vga_ctrl v_C(clk_vga,1'b0,data,h_addr,v_addr,hsync,vsync,valid,vga[23:16],vga[15:8],vga[7:0]);
//rom_font rf(.address(address),.clock(clk_vga),.q(font));
//ram_vga rv(block_addr,index,clk_vga,KB_CLK,1'b0,ascii_data,1'b0,1'b1,ram_vga_ret,out_useless);


//calls
//generate clock
clkgen #25000000 c1(clk,1'b0,1'b1,VGA_CLK);
//clkgen #25000000 c1(clk,1'b0,1'b1,clk_vga);
clkgen #20 c2(clk,1'b0,1'b1,KB_CLK);

//VGA CTRL
//vga_ctrl vc(
//		.pclk(clk),
//		.reset(1'b0),
//		.vga_data(data),
//		.h_addr(h_addr),
//		.v_addr(v_addr),
//		.hsync(hsync),
//		.vsync(vsync),
//		.valid(valid),
//		.vga_r(vga[23:16]),
//		.vga_g(vga[15:8]),
//		.vga_b(vga[7:0])
//);
vga_ctrl vctrl(
		.pclk(VGA_CLK),
		.reset(1'b0),
		.vga_data(data),
		.h_addr(h_addr),
		.v_addr(v_addr),
		.hsync(VGA_HS),
		.vsync(VGA_VS),
		.valid(VGA_BLANK_N),
		.vga_r(VGA_R),
		.vga_g(VGA_G),
		.vga_b(VGA_B)
);



//char point matrix
rom_font rf(
		.address(address),
		.clock(VGA_CLK/*clk_vga*/),
		.q(font)
);

//Video memory(two ports)
//VGA:read only | keyboard:write only
ram_vga rv(
		.address_a(block_addr),
		.address_b(index),
		.clock_a(VGA_CLK),
		.clock_b(KB_CLK),
		.data_a(8'h00),
		.data_b(ascii_data),
		.wren_a(1'b0), // VGA read only
		.wren_b(1'b1), // kb write only
		.q_a(ram_vga_ret),
		.q_b(out_useless)
);



//always module
//always @(KB_CLK)begin
//	if(index < 12'd70)begin
//		preindex <= 0;
//	end
//	else begin
//		preindex <= ram_index[(index/70)-1];
//	end
//end


always @(VGA_CLK)begin
	 block_addr <= (v_addr >> 4) * 70 + ((h_addr) / 9);
	 address <= (ram_vga_ret << 4) + (v_addr % 16);
    //block_addr <= ((v_addr >> 4) << 6) + ((v_addr >> 4) << 2) + ((v_addr >> 4) << 1)
	 //+ ((h_addr >> 3) - h_addr); //get current block addr
	 //address <= (ram_vga_ret << 4) + (v_addr & 10'b0000001111); //get matrix line
	 if(font[(h_addr) % 9] == 1'b1)
		data <= 24'hffffff;
	 else
		data <= 24'h000000;
end	


always @(posedge KB_CLK) begin
    if(ascii != 0) 
		begin
			if(cnt == 0 )
			begin
				if(ascii == 8'h0d)begin//hit enter
					 backspace_state <= 0;
					 //ram_index[index/70] <= index + 1;
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
//						if((index + 1) % 70 == 0)begin
//							ram_index[(index-1)/70] <= index;
//						end
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
//						if((index + 1) % 70 == 0)begin
//							ram_index[(index-1)/70] <= index;
//						end							
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

endmodule 
