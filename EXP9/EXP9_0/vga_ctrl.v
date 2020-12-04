module vga_ctrl(
	input pclk,
	input reset, //置位
	input [23:0] vga_data, // 上 层 模 块 提 供 的 VGA颜色数据
	output [9:0] h_addr, // 提 供 给 上 层 模 块 的 当 前 扫 描 像 素 点 坐 标
	output [9:0] v_addr,
	output hsync, // 行 同 步 和 列 同 步 信 号
	output vsync,
	output valid, //消隐信号
	output [7:0] vga_r, // 红 绿 蓝 颜 色 信 号
	output [7:0] vga_g,
	output [7:0] vga_b
);

//640x480 分辨 率 下的 VGA参数设置
parameter h_frontporch = 96;
parameter h_active = 144;
parameter h_backporch = 784;
parameter h_total = 800;

parameter v_frontporch = 2;
parameter v_active = 35;
parameter v_backporch = 515;
parameter v_total = 525;

// 像素 计 数值
reg [9:0] x_cnt;
reg [9:0] y_cnt;
wire h_valid;
wire v_valid;

always @(posedge reset or posedge pclk) // 行像 素 计数
begin
	if (reset == 1'b1)
		x_cnt <= 1;
	else begin
		if (x_cnt == h_total)
			x_cnt <= 1;
		else
			x_cnt <= x_cnt + 10'd1;
	end
end

always @(posedge pclk) // 列像 素 计数
begin
	if (reset == 1'b1)
		y_cnt <= 1;
	else begin
		if (y_cnt == v_total & x_cnt == h_total)
			y_cnt <= 1;
		else if (x_cnt == h_total)
			y_cnt <= y_cnt + 10'd1;
	end
end 
// 生 成 同 步 信 号
assign hsync = (x_cnt > h_frontporch);
assign vsync = (y_cnt > v_frontporch);
// 生 成 消 隐 信 号
assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch);
assign valid = (h_valid & v_valid);//这里已改为低电平有效
// 计 算 当 前 有 效 像 素 坐 标
assign h_addr = h_valid ? (x_cnt - 10'd145) : {10{1'b0}};
assign v_addr = v_valid ? (y_cnt - 10'd36) : {10{1'b0}};
// 设 置 输 出 的 颜 色 值
assign vga_r = vga_data[23:16];
assign vga_g = vga_data[15:8];
assign vga_b = vga_data[7:0];
endmodule
