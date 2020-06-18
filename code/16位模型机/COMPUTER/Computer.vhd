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

ENTITY Computer IS 
	port
	(
		RST1 :  IN  STD_LOGIC;
		SWA :  IN  STD_LOGIC;
		SWB :  IN  STD_LOGIC;
		CLK1 :  IN  STD_LOGIC;
		STEP :  IN  STD_LOGIC;
		watch :  IN  STD_LOGIC;
		clear :  IN  STD_LOGIC;
		d0 :  IN  STD_LOGIC_VECTOR(7 downto 0);
		LED_B :  OUT  STD_LOGIC;
		SW_B :  OUT  STD_LOGIC;
		PC_B :  OUT  STD_LOGIC;
		ALU_B :  OUT  STD_LOGIC;
		R0_B :  OUT  STD_LOGIC;
		RAM_B :  OUT  STD_LOGIC;
		LOAD :  OUT  STD_LOGIC;
		d3 :  OUT  STD_LOGIC_VECTOR(7 downto 0);
		I :  OUT  STD_LOGIC_VECTOR(7 downto 0);
		in :  OUT  STD_LOGIC_VECTOR(7 downto 0);
		led :  OUT  STD_LOGIC_VECTOR(7 downto 0);
		M :  OUT  STD_LOGIC_VECTOR(24 downto 1);
		num :  OUT  STD_LOGIC_VECTOR(3 downto 0);
		uaddr :  OUT  STD_LOGIC_VECTOR(6 downto 1);
		window :  OUT  STD_LOGIC_VECTOR(7 downto 0)
	);
END Computer;

ARCHITECTURE bdf_type OF Computer IS 

attribute black_box : boolean;
attribute noopt : boolean;

component \74148_0\
	PORT(5N : IN STD_LOGIC;
		 0N : IN STD_LOGIC;
		 1N : IN STD_LOGIC;
		 2N : IN STD_LOGIC;
		 3N : IN STD_LOGIC;
		 4N : IN STD_LOGIC;
		 EIN : IN STD_LOGIC;
		 6N : IN STD_LOGIC;
		 7N : IN STD_LOGIC;
		 A1N : OUT STD_LOGIC;
		 A0N : OUT STD_LOGIC;
		 A2N : OUT STD_LOGIC);
end component;
attribute black_box of \74148_0\: component is true;
attribute noopt of \74148_0\: component is true;

component \273\
	PORT(CLK : IN STD_LOGIC;
		 CLRN : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 downto 0);
		 Q : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component alu2
	PORT(M : IN STD_LOGIC;
		 CN : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(7 downto 0);
		 B : IN STD_LOGIC_VECTOR(7 downto 0);
		 S : IN STD_LOGIC_VECTOR(3 downto 0);
		 CN4 : OUT STD_LOGIC;
		 AEQB : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component lpm_mux1
	PORT(data0x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data1x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data2x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data3x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data4x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data5x : IN STD_LOGIC_VECTOR(7 downto 0);
		 data6x : IN STD_LOGIC_VECTOR(7 downto 0);
		 sel : IN STD_LOGIC_VECTOR(2 downto 0);
		 result : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component se5_1
	PORT(FC : IN STD_LOGIC;
		 FZ : IN STD_LOGIC;
		 T4 : IN STD_LOGIC;
		 SWA : IN STD_LOGIC;
		 SWB : IN STD_LOGIC;
		 I : IN STD_LOGIC_VECTOR(7 downto 2);
		 P : IN STD_LOGIC_VECTOR(4 downto 1);
		 SE : OUT STD_LOGIC_VECTOR(6 downto 1)
	);
end component;

component se6_1
	PORT(CLR : IN STD_LOGIC;
		 CLK : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(6 downto 1);
		 SE : IN STD_LOGIC_VECTOR(6 downto 1);
		 q : OUT STD_LOGIC_VECTOR(6 downto 1)
	);
end component;

component decodec
	PORT(A : IN STD_LOGIC;
		 B : IN STD_LOGIC;
		 C : IN STD_LOGIC;
		 LDPC : OUT STD_LOGIC;
		 P : OUT STD_LOGIC_VECTOR(4 downto 1)
	);
end component;

component decodea
	PORT(A : IN STD_LOGIC;
		 B : IN STD_LOGIC;
		 C : IN STD_LOGIC;
		 LDRI : OUT STD_LOGIC;
		 LDDR1 : OUT STD_LOGIC;
		 LDDR2 : OUT STD_LOGIC;
		 LDIR : OUT STD_LOGIC;
		 LOAD : OUT STD_LOGIC;
		 LDAR : OUT STD_LOGIC
	);
end component;

component decodeb
	PORT(A : IN STD_LOGIC;
		 B : IN STD_LOGIC;
		 C : IN STD_LOGIC;
		 RS_B : OUT STD_LOGIC;
		 RD_B : OUT STD_LOGIC;
		 RJ_B : OUT STD_LOGIC;
		 ALU_B : OUT STD_LOGIC;
		 PC_B : OUT STD_LOGIC
	);
end component;

component decode2_4
	PORT(D : IN STD_LOGIC_VECTOR(1 downto 0);
		 Y : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
end component;

component ldr0_2
	PORT(RS_B : IN STD_LOGIC;
		 RD_B : IN STD_LOGIC;
		 RJ_B : IN STD_LOGIC;
		 I3 : IN STD_LOGIC;
		 I2 : IN STD_LOGIC;
		 I1 : IN STD_LOGIC;
		 I0 : IN STD_LOGIC;
		 LDRI : IN STD_LOGIC;
		 R0_B : OUT STD_LOGIC;
		 R1_B : OUT STD_LOGIC;
		 R2_B : OUT STD_LOGIC;
		 LDR0 : OUT STD_LOGIC;
		 LDR1 : OUT STD_LOGIC;
		 LDR2 : OUT STD_LOGIC
	);
end component;

component display
	PORT(clk : IN STD_LOGIC;
		 clr : IN STD_LOGIC;
		 p0 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p1 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p2 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p3 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p4 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p5 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p6 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p7 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p8 : IN STD_LOGIC_VECTOR(7 downto 0);
		 p9 : IN STD_LOGIC_VECTOR(7 downto 0);
		 pA : IN STD_LOGIC_VECTOR(7 downto 0);
		 pB : IN STD_LOGIC_VECTOR(7 downto 0);
		 pC : IN STD_LOGIC_VECTOR(7 downto 0);
		 count : OUT STD_LOGIC_VECTOR(3 downto 0);
		 q : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component reg_3
	PORT(T4 : IN STD_LOGIC;
		 LDR0 : IN STD_LOGIC;
		 LDR1 : IN STD_LOGIC;
		 LDR2 : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 downto 0);
		 R0 : OUT STD_LOGIC_VECTOR(7 downto 0);
		 R1 : OUT STD_LOGIC_VECTOR(7 downto 0);
		 R2 : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component lpm_counter0
	PORT(clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 aload : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 downto 0);
		 q : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component lpm_ram_dq0
	PORT(wren : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(7 downto 0);
		 data : IN STD_LOGIC_VECTOR(7 downto 0);
		 q : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component rom_a
	PORT(clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(5 downto 0);
		 q : OUT STD_LOGIC_VECTOR(23 downto 0)
	);
end component;

component t4
	PORT(S0 : IN STD_LOGIC;
		 CLK1 : IN STD_LOGIC;
		 RST1 : IN STD_LOGIC;
		 T1 : OUT STD_LOGIC;
		 T2 : OUT STD_LOGIC;
		 T3 : OUT STD_LOGIC;
		 T4 : OUT STD_LOGIC
	);
end component;

signal	A :  STD_LOGIC_VECTOR(7 downto 0);
signal	addr :  STD_LOGIC_VECTOR(7 downto 0);
signal	ALU_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	B :  STD_LOGIC_VECTOR(7 downto 0);
signal	bus :  STD_LOGIC_VECTOR(7 downto 0);
signal	d1 :  STD_LOGIC_VECTOR(7 downto 0);
signal	d2 :  STD_LOGIC_VECTOR(7 downto 0);
signal	d3_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 downto 0);
signal	d4 :  STD_LOGIC_VECTOR(7 downto 0);
signal	d5 :  STD_LOGIC_VECTOR(7 downto 0);
signal	d6 :  STD_LOGIC_VECTOR(7 downto 0);
signal	FC :  STD_LOGIC;
signal	FZ :  STD_LOGIC;
signal	gdfx_temp0 :  STD_LOGIC_VECTOR(1 downto 0);
signal	I_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 downto 0);
signal	LDAR :  STD_LOGIC;
signal	LDDR1 :  STD_LOGIC;
signal	LDDR2 :  STD_LOGIC;
signal	LDIR :  STD_LOGIC;
signal	LDPC :  STD_LOGIC;
signal	LDRI :  STD_LOGIC;
signal	led_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 downto 0);
signal	LED_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	LOAD_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	M_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(24 downto 1);
signal	P :  STD_LOGIC_VECTOR(4 downto 1);
signal	PC_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	R0_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	R1_B :  STD_LOGIC;
signal	R2_B :  STD_LOGIC;
signal	RAM_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	RD_B :  STD_LOGIC;
signal	RJ_B :  STD_LOGIC;
signal	RS_B :  STD_LOGIC;
signal	SEL :  STD_LOGIC_VECTOR(2 downto 0);
signal	SW_B_ALTERA_SYNTHESIZED :  STD_LOGIC;
signal	T1 :  STD_LOGIC;
signal	T2 :  STD_LOGIC;
signal	T3 :  STD_LOGIC;
signal	T4 :  STD_LOGIC;
signal	uaddr_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(6 downto 1);
signal	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(6 downto 1);
signal	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_18 :  STD_LOGIC_VECTOR(7 downto 0);
signal	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_26 :  STD_LOGIC;

signal	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(4 downto 1);
signal	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(3 downto 0);

BEGIN 
SYNTHESIZED_WIRE_4 <= '1';
SYNTHESIZED_WIRE_5 <= '0';
SYNTHESIZED_WIRE_26 <= '1';

P(1) <= GDFX_TEMP_SIGNAL_0(4);
P(2) <= GDFX_TEMP_SIGNAL_0(3);
P(3) <= GDFX_TEMP_SIGNAL_0(2);
P(4) <= GDFX_TEMP_SIGNAL_0(1);

LED_B_ALTERA_SYNTHESIZED <= GDFX_TEMP_SIGNAL_1(3);
SW_B_ALTERA_SYNTHESIZED <= GDFX_TEMP_SIGNAL_1(2);
RAM_B_ALTERA_SYNTHESIZED <= GDFX_TEMP_SIGNAL_1(1);



b2v_addressreg : \273\
PORT MAP(CLK => SYNTHESIZED_WIRE_0,
		 CLRN => RST1,
		 D => bus,
		 Q => addr);

b2v_inst1 : alu2
PORT MAP(M => M_ALTERA_SYNTHESIZED(20),
		 CN => M_ALTERA_SYNTHESIZED(19),
		 A => A,
		 B => B,
		 S => M_ALTERA_SYNTHESIZED(24 downto 21),
		 CN4 => FC,
		 AEQB => FZ,
		 F => d1);

SYNTHESIZED_WIRE_25 <= NOT(LED_B_ALTERA_SYNTHESIZED);


SYNTHESIZED_WIRE_3 <= T2 AND LDDR2;

SYNTHESIZED_WIRE_2 <= T2 AND LDDR1;

SYNTHESIZED_WIRE_24 <= T2 AND LDIR;

SYNTHESIZED_WIRE_0 <= LDAR AND T4;

b2v_inst15 : lpm_mux1
PORT MAP(data0x => d0,
		 data1x => d1,
		 data2x => d2,
		 data3x => d3_ALTERA_SYNTHESIZED,
		 data4x => d4,
		 data5x => d5,
		 data6x => d6,
		 sel => SEL,
		 result => bus);

b2v_inst16 : se5_1
PORT MAP(FC => FC,
		 FZ => FZ,
		 T4 => T4,
		 SWA => SWA,
		 SWB => SWB,
		 I => I_ALTERA_SYNTHESIZED(7 downto 2),
		 P => P,
		 SE => SYNTHESIZED_WIRE_1);
in <= d0;


b2v_inst18 : se6_1
PORT MAP(CLR => RST1,
		 CLK => T2,
		 D => M_ALTERA_SYNTHESIZED(6 downto 1),
		 SE => SYNTHESIZED_WIRE_1,
		 q => uaddr_ALTERA_SYNTHESIZED);

b2v_inst2 : decodec
PORT MAP(A => M_ALTERA_SYNTHESIZED(7),
		 B => M_ALTERA_SYNTHESIZED(8),
		 C => M_ALTERA_SYNTHESIZED(9),
		 LDPC => LDPC,
		 P => GDFX_TEMP_SIGNAL_0);

SYNTHESIZED_WIRE_22 <= T2 AND LDPC;
SYNTHESIZED_WIRE_6 <= d0;


b2v_inst22 : decodea
PORT MAP(A => M_ALTERA_SYNTHESIZED(13),
		 B => M_ALTERA_SYNTHESIZED(14),
		 C => M_ALTERA_SYNTHESIZED(15),
		 LDRI => LDRI,
		 LDDR1 => LDDR1,
		 LDDR2 => LDDR2,
		 LDIR => LDIR,
		 LOAD => LOAD_ALTERA_SYNTHESIZED,
		 LDAR => LDAR);

b2v_inst23 : decodeb
PORT MAP(A => M_ALTERA_SYNTHESIZED(10),
		 B => M_ALTERA_SYNTHESIZED(11),
		 C => M_ALTERA_SYNTHESIZED(12),
		 RS_B => RS_B,
		 RD_B => RD_B,
		 RJ_B => RJ_B,
		 ALU_B => ALU_B_ALTERA_SYNTHESIZED,
		 PC_B => PC_B_ALTERA_SYNTHESIZED);
SYNTHESIZED_WIRE_14 <= led_ALTERA_SYNTHESIZED;

SYNTHESIZED_WIRE_7 <= d1;


b2v_inst3 : decode2_4
PORT MAP(D => gdfx_temp0,
		 Y => GDFX_TEMP_SIGNAL_1);
SYNTHESIZED_WIRE_10 <= d4;

SYNTHESIZED_WIRE_9 <= d3_ALTERA_SYNTHESIZED;

SYNTHESIZED_WIRE_8 <= d2;

SYNTHESIZED_WIRE_11 <= d5;

SYNTHESIZED_WIRE_12 <= d6;

SYNTHESIZED_WIRE_13 <= bus;

SYNTHESIZED_WIRE_18 <= I_ALTERA_SYNTHESIZED;

SYNTHESIZED_WIRE_15 <= M_ALTERA_SYNTHESIZED(8 downto 1);


b2v_inst4 : ldr0_2
PORT MAP(RS_B => RS_B,
		 RD_B => RD_B,
		 RJ_B => RJ_B,
		 I3 => I_ALTERA_SYNTHESIZED(3),
		 I2 => I_ALTERA_SYNTHESIZED(2),
		 I1 => I_ALTERA_SYNTHESIZED(1),
		 I0 => I_ALTERA_SYNTHESIZED(0),
		 LDRI => LDRI,
		 R0_B => R0_B_ALTERA_SYNTHESIZED,
		 R1_B => R1_B,
		 R2_B => R2_B,
		 LDR0 => SYNTHESIZED_WIRE_19,
		 LDR1 => SYNTHESIZED_WIRE_20,
		 LDR2 => SYNTHESIZED_WIRE_21);
SYNTHESIZED_WIRE_16 <= M_ALTERA_SYNTHESIZED(16 downto 9);

SYNTHESIZED_WIRE_17 <= M_ALTERA_SYNTHESIZED(24 downto 17);


b2v_inst42 : \273\
PORT MAP(CLK => SYNTHESIZED_WIRE_2,
		 CLRN => RST1,
		 D => bus,
		 Q => A);

b2v_inst43 : \273\
PORT MAP(CLK => SYNTHESIZED_WIRE_3,
		 CLRN => RST1,
		 D => bus,
		 Q => B);

b2v_inst44 : 74148_0
PORT MAP(5N => RAM_B_ALTERA_SYNTHESIZED,
		 0N => SYNTHESIZED_WIRE_4,
		 1N => R2_B,
		 2N => R1_B,
		 3N => R0_B_ALTERA_SYNTHESIZED,
		 4N => PC_B_ALTERA_SYNTHESIZED,
		 EIN => SYNTHESIZED_WIRE_5,
		 6N => ALU_B_ALTERA_SYNTHESIZED,
		 7N => SW_B_ALTERA_SYNTHESIZED,
		 A1N => SEL(1),
		 A0N => SEL(0),
		 A2N => SEL(2));

b2v_inst5 : display
PORT MAP(clk => watch,
		 clr => clear,
		 p0 => SYNTHESIZED_WIRE_6,
		 p1 => SYNTHESIZED_WIRE_7,
		 p2 => SYNTHESIZED_WIRE_8,
		 p3 => SYNTHESIZED_WIRE_9,
		 p4 => SYNTHESIZED_WIRE_10,
		 p5 => SYNTHESIZED_WIRE_11,
		 p6 => SYNTHESIZED_WIRE_12,
		 p7 => SYNTHESIZED_WIRE_13,
		 p8 => SYNTHESIZED_WIRE_14,
		 p9 => SYNTHESIZED_WIRE_15,
		 pA => SYNTHESIZED_WIRE_16,
		 pB => SYNTHESIZED_WIRE_17,
		 pC => SYNTHESIZED_WIRE_18,
		 count => num,
		 q => window);

b2v_inst6 : reg_3
PORT MAP(T4 => T4,
		 LDR0 => SYNTHESIZED_WIRE_19,
		 LDR1 => SYNTHESIZED_WIRE_20,
		 LDR2 => SYNTHESIZED_WIRE_21,
		 D => bus,
		 R0 => d4,
		 R1 => d5,
		 R2 => d6);

b2v_inst7 : lpm_counter0
PORT MAP(clock => SYNTHESIZED_WIRE_22,
		 aclr => SYNTHESIZED_WIRE_23,
		 aload => LOAD_ALTERA_SYNTHESIZED,
		 data => bus,
		 q => d3_ALTERA_SYNTHESIZED);

SYNTHESIZED_WIRE_23 <= NOT(RST1);


b2v_InstructionsRAM : lpm_ram_dq0
PORT MAP(wren => M_ALTERA_SYNTHESIZED(18),
		 clock => CLK1,
		 address => addr,
		 data => bus,
		 q => d2);

b2v_IR : \273\
PORT MAP(CLK => SYNTHESIZED_WIRE_24,
		 CLRN => RST1,
		 D => bus,
		 Q => I_ALTERA_SYNTHESIZED);

b2v_Micro-controller : rom_a
PORT MAP(clock => T1,
		 address => uaddr_ALTERA_SYNTHESIZED,
		 q => M);

b2v_outputdevice : \273\
PORT MAP(CLK => SYNTHESIZED_WIRE_25,
		 CLRN => RST1,
		 D => bus,
		 Q => led_ALTERA_SYNTHESIZED);

b2v_timing : t4
PORT MAP(S0 => SYNTHESIZED_WIRE_26,
		 CLK1 => CLK1,
		 RST1 => STEP,
		 T1 => T1,
		 T2 => T2,
		 T4 => T4);
LED_B <= LED_B_ALTERA_SYNTHESIZED;
SW_B <= SW_B_ALTERA_SYNTHESIZED;
PC_B <= PC_B_ALTERA_SYNTHESIZED;
ALU_B <= ALU_B_ALTERA_SYNTHESIZED;
R0_B <= R0_B_ALTERA_SYNTHESIZED;
RAM_B <= RAM_B_ALTERA_SYNTHESIZED;
LOAD <= LOAD_ALTERA_SYNTHESIZED;
d3 <= d3_ALTERA_SYNTHESIZED;
I <= I_ALTERA_SYNTHESIZED;
led <= led_ALTERA_SYNTHESIZED;
uaddr <= uaddr_ALTERA_SYNTHESIZED;

gdfx_temp0(1) <= M_ALTERA_SYNTHESIZED(17);
gdfx_temp0(0) <= M_ALTERA_SYNTHESIZED(16);
END; 