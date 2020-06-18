-- Copyright (C) 1991-2004 Altera Corporation
-- Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
-- support information,  device programming or simulation file,  and any other
-- associated  documentation or information  provided by  Altera  or a partner
-- under  Altera's   Megafunction   Partnership   Program  may  be  used  only
-- to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
-- other  use  of such  megafunction  design,  netlist,  support  information,
-- device programming or simulation file,  or any other  related documentation
-- or information  is prohibited  for  any  other purpose,  including, but not
-- limited to  modification,  reverse engineering,  de-compiling, or use  with
-- any other  silicon devices,  unless such use is  explicitly  licensed under
-- a separate agreement with  Altera  or a megafunction partner.  Title to the
-- intellectual property,  including patents,  copyrights,  trademarks,  trade
-- secrets,  or maskworks,  embodied in any such megafunction design, netlist,
-- support  information,  device programming or simulation file,  or any other
-- related documentation or information provided by  Altera  or a megafunction
-- partner, remains with Altera, the megafunction partner, or their respective
-- licensors. No other licenses, including any licenses needed under any third
-- party's intellectual property, are provided herein.

-- PROGRAM "Quartus II"
-- VERSION "Version 4.1 Build 181 06/29/2004 SJ Full Version"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
LIBRARY work;

ENTITY 74148_0 IS 
PORT 
( 
	5N	:	IN	 STD_LOGIC;
	0N	:	IN	 STD_LOGIC;
	1N	:	IN	 STD_LOGIC;
	2N	:	IN	 STD_LOGIC;
	3N	:	IN	 STD_LOGIC;
	4N	:	IN	 STD_LOGIC;
	EIN	:	IN	 STD_LOGIC;
	6N	:	IN	 STD_LOGIC;
	7N	:	IN	 STD_LOGIC;
	A1N	:	OUT	 STD_LOGIC;
	A0N	:	OUT	 STD_LOGIC;
	A2N	:	OUT	 STD_LOGIC
); 
END 74148_0;

ARCHITECTURE bdf_type OF 74148_0 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst44 : 74148
PORT MAP(5N => 5N,
		 0N => 0N,
		 1N => 1N,
		 2N => 2N,
		 3N => 3N,
		 4N => 4N,
		 EIN => EIN,
		 6N => 6N,
		 7N => 7N,
		 A1N => A1N,
		 A0N => A0N,
		 A2N => A2N);

END; 