-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 9.0 Build 132 02/25/2009 SJ Full Version"
-- CREATED ON		"Mon Mar 11 09:40:06 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
LIBRARY work;

ENTITY 74181_1 IS 
PORT 
( 
	B0N	:	IN	 STD_LOGIC;
	A0N	:	IN	 STD_LOGIC;
	A1N	:	IN	 STD_LOGIC;
	B1N	:	IN	 STD_LOGIC;
	A3N	:	IN	 STD_LOGIC;
	B2N	:	IN	 STD_LOGIC;
	A2N	:	IN	 STD_LOGIC;
	M	:	IN	 STD_LOGIC;
	CN	:	IN	 STD_LOGIC;
	B3N	:	IN	 STD_LOGIC;
	S2	:	IN	 STD_LOGIC;
	S1	:	IN	 STD_LOGIC;
	S0	:	IN	 STD_LOGIC;
	S3	:	IN	 STD_LOGIC;
	F3N	:	OUT	 STD_LOGIC;
	F1N	:	OUT	 STD_LOGIC;
	F0N	:	OUT	 STD_LOGIC;
	AEQB	:	OUT	 STD_LOGIC;
	CN4	:	OUT	 STD_LOGIC;
	F2N	:	OUT	 STD_LOGIC
); 
END 74181_1;

ARCHITECTURE bdf_type OF 74181_1 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst1 : 74181
PORT MAP(B0N => B0N,
		 A0N => A0N,
		 A1N => A1N,
		 B1N => B1N,
		 A3N => A3N,
		 B2N => B2N,
		 A2N => A2N,
		 M => M,
		 CN => CN,
		 B3N => B3N,
		 S2 => S2,
		 S1 => S1,
		 S0 => S0,
		 S3 => S3,
		 F3N => F3N,
		 F1N => F1N,
		 F0N => F0N,
		 AEQB => AEQB,
		 CN4 => CN4,
		 F2N => F2N);

END bdf_type; 