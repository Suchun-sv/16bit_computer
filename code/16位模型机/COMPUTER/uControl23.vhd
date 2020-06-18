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
-- CREATED ON		"Tue Mar 12 09:23:08 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY uControl IS 
	PORT
	(
		FC :  IN  STD_LOGIC;
		FZ :  IN  STD_LOGIC;
		T4 :  IN  STD_LOGIC;
		SWA :  IN  STD_LOGIC;
		SWB :  IN  STD_LOGIC;
		I :  IN  STD_LOGIC_VECTOR(15 DOWNTO 10);
		P :  IN  STD_LOGIC_VECTOR(4 DOWNTO 1);
		SE :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 1)
	);
END uControl;

ARCHITECTURE bdf_type OF uControl IS 

SIGNAL	SE_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(6 DOWNTO 1);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;


BEGIN 



SE_ALTERA_SYNTHESIZED(5) <= NOT(SYNTHESIZED_WIRE_0 AND T4 AND P(3));


SE_ALTERA_SYNTHESIZED(1) <= NOT(SYNTHESIZED_WIRE_1 OR SYNTHESIZED_WIRE_2 OR SYNTHESIZED_WIRE_3);


SYNTHESIZED_WIRE_0 <= FZ OR FC;



SE_ALTERA_SYNTHESIZED(4) <= NOT(I(15) AND T4 AND P(1));


SE_ALTERA_SYNTHESIZED(3) <= NOT(I(14) AND T4 AND P(1));


SYNTHESIZED_WIRE_4 <= I(13) AND T4 AND P(1);


SYNTHESIZED_WIRE_5 <= I(11) AND T4 AND P(2);


SYNTHESIZED_WIRE_6 <= P(4) AND T4 AND SWB;


SYNTHESIZED_WIRE_1 <= I(12) AND T4 AND P(1);


SYNTHESIZED_WIRE_2 <= I(10) AND T4 AND P(2);


SYNTHESIZED_WIRE_3 <= P(4) AND T4 AND SWA;


SE_ALTERA_SYNTHESIZED(2) <= NOT(SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_5 OR SYNTHESIZED_WIRE_6);

SE <= SE_ALTERA_SYNTHESIZED;

SE_ALTERA_SYNTHESIZED(6) <= '1';
END bdf_type;