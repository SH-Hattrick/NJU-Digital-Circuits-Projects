module ram(in,out,CapsLock);
input [7:0] in;
input CapsLock;
output reg [7:0] out;
reg [7:0] ram [255:0];
wire [7:0]now;

initial
begin
	$readmemh("scancode.txt", ram, 0, 255); 
end

assign now = ram[in];

always @ (in)
begin
	if(CapsLock==1'b1)begin 
		if(now >= 8'h61 && now <= 8'h7a)
			out <= now - 6'h20;
		else
			out <= now;
		end
	else 
		out <= now;
end

endmodule 