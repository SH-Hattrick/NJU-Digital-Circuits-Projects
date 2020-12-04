module VGA(
	input CLOCK_50,
	input clr,
	input [1:0]mode,
	
	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);
//inner signal
//reg reset;
wire [9:0] h_addr;
wire [9:0] v_addr;
wire [23:0] vga_data;


//assign module
assign VGA_SYNC_N = 1'b0;

//modules call
//clkgen #(25000000) my_vgaclk(CLOCK_50,1'b0,1'b1,VGA_CLK);

//vga_ctrl ctrl(.pclk(VGA_CLK),.vga_r(VGA_R),.vga_g(VGA_G),.vga_b(VGA_B),
	//.valid(VGA_BLANK_N),.vsync(VGA_VS),.hsync(VGA_HS),.v_addr(v_addr),
	//.h_addr(h_addr),.reset(reset),.vga_data(vga_data));
	
top_flyinglogo tfl(.clk(CLOCK_50), .rst(0), .hsync(VGA_HS), .vsync(VGA_VS),
						.vga_r(VGA_R[7:4]), .vga_g(VGA_G[7:4]), .vga_b(VGA_B[7:4])
						,.pclk(VGA_CLK),.valid(VGA_BLANK_N));
//picdisplay sd(.h_addr(h_addr),.v_addr(v_addr),.vga_data(vga_data),.clk(CLOCK_50),.en(1));


/*
module top_flyinglogo(clk, rst, hsync, vsync, vga_r, vga_g, vga_b);
   input           clk;
   input           rst;
   
   output          hsync;
   output          vsync;
   output [3:0]    vga_r;
   output [3:0]    vga_g;
   output [3:0]    vga_b;
	*/

endmodule 