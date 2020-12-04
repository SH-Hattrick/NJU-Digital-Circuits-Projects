// megafunction wizard: %RAM initializer%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTMEM_INIT 

// ============================================================
// File Name: mypic.v
// Megafunction Name(s):
// 			ALTMEM_INIT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.0 Build 590 10/25/2017 SJ Lite Edition
// ************************************************************

//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.

module mypic (
	clock,
	init,
	dataout,
	init_busy,
	ram_address,
	ram_wren)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	  init;
	output	[11:0]  dataout;
	output	  init_busy;
	output	[18:0]  ram_address;
	output	  ram_wren;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: INIT_FILE STRING "UNUSED"
// Retrieval info: CONSTANT: INIT_TO_ZERO STRING "YES"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altmem_init"
// Retrieval info: CONSTANT: NUMWORDS NUMERIC "327680"
// Retrieval info: CONSTANT: PORT_ROM_DATA_READY STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: ROM_READ_LATENCY NUMERIC "1"
// Retrieval info: CONSTANT: WIDTH NUMERIC "12"
// Retrieval info: CONSTANT: WIDTHAD NUMERIC "19"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: dataout 0 0 12 0 OUTPUT NODEFVAL "dataout[11..0]"
// Retrieval info: CONNECT: dataout 0 0 12 0 @dataout 0 0 12 0
// Retrieval info: USED_PORT: init 0 0 0 0 INPUT NODEFVAL "init"
// Retrieval info: CONNECT: @init 0 0 0 0 init 0 0 0 0
// Retrieval info: USED_PORT: init_busy 0 0 0 0 OUTPUT NODEFVAL "init_busy"
// Retrieval info: CONNECT: init_busy 0 0 0 0 @init_busy 0 0 0 0
// Retrieval info: USED_PORT: ram_address 0 0 19 0 OUTPUT NODEFVAL "ram_address[18..0]"
// Retrieval info: CONNECT: ram_address 0 0 19 0 @ram_address 0 0 19 0
// Retrieval info: USED_PORT: ram_wren 0 0 0 0 OUTPUT NODEFVAL "ram_wren"
// Retrieval info: CONNECT: ram_wren 0 0 0 0 @ram_wren 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mypic.cmp TRUE TRUE
// Retrieval info: LIB_FILE: lpm
