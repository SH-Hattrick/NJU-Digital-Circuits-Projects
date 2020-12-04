module picdisplay(
	output reg[23:0] vga_data,
	input [9:0] h_addr,
	input [9:0] v_addr,
	input clk,
	input en
);
//inner signal
reg [18:0] addr;
wire [11:0] data;

//initial
initial
begin
	vga_data = 24'd0;
end


//always module
always @ (h_addr or v_addr)
begin
	if(h_addr > 300 && h_addr < 330)
	begin
		vga_data = 24'h103050;
	end
	else vga_data = 24'hf0f0f0;
end

endmodule 