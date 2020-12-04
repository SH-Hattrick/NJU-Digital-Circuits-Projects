module RAM1(
	input en,
	input clock,
	input [7:0]data,
	input [3:0]rdaddress,
	input [3:0]wraddress,
	input wren,
	output reg [7:0]q
);
//registers
reg [7:0]mem [15:0];

//initial
initial
begin
$readmemh("test.txt", mem, 0, 15);
end

//always module
always @ (posedge clock)
begin
if(en == 0)
	if(wren)//写有效
		mem[wraddress] <= data;
	else q <= mem[rdaddress];
else q <= q;
end
endmodule 
/*请在一个工程中完成如下两个存储器。两个存储器的大小均为 16×8，即每
个存储器共有 16 个存储单元，每个存储单元都是 8 位的，均可以进行读写。
RAM1：采用下面的方式进行初始化，输出端有输出缓存，输出地址有
效后，等时钟信号的上升沿到来时才输出数据。
RAM2：利用 IP 核设计一个双口存储器，利用.mif 文件进行初始化，
十六个单元的初始化值分别为：0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6,0xf7,0xf8,
0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff。
此两个物理上完全不同的存储器共用时钟、读写地址和写使能信号，当写
使能有效时，在时钟信号的有效沿写入数据；当写使能信号无效时，在时钟信
号的有效沿输出数据。适当选择时钟信号和写使能信号，以能够分别对此两个
存储器进行读写。
*/
