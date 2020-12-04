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
pic mypic(addr, clk, data);

//initial
initial
begin
	vga_data = 24'd0;
end


//always module
always @ (h_addr or v_addr)
begin
	if(en)
	begin
	addr = {h_addr, v_addr[8:0]};
	vga_data = {data[11:8], 4'b0000, data[7:4], 4'b0000, data[3:0], 4'b0000};
	end
end

endmodule 