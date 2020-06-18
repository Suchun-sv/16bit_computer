LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY uControl2 IS 
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
END uControl2;

ARCHITECTURE behav OF uControl2 IS 

SIGNAL	res :  STD_LOGIC_VECTOR(6 DOWNTO 1);
SIGNAL	a0 :  STD_LOGIC;
SIGNAL	a1 :  STD_LOGIC;
SIGNAL	a2 :  STD_LOGIC;
SIGNAL	a3 :  STD_LOGIC;
SIGNAL	a4 :  STD_LOGIC;
SIGNAL	a5 :  STD_LOGIC;
SIGNAL	a6 :  STD_LOGIC;


BEGIN 

process(FC,FZ,T4,SWA,SWB,I,P)
begin

	if T4='1' then
		if P(4)='1' then
			if SWA='1' and SWB='0' then
				res<="110110";
			elsif SWA='0' and SWB='0' then
				res<="110111";
			else
				res<="110100";
			end if;
		elsif P(1)='1' then
			if I(15 downto 10)="000000" then
				res<="111111";
			end if;
			if I(15 downto 10)="000001" then
				res<="111110";
			end if;
			if I(15 downto 10)="000010" then
				res<="111101";
			end if;
			if I(15 downto 10)="000011" then
				res<="111100";
			end if;
			if I(15 downto 10)="000100" then
				res<="111011";
			end if;
			if I(15 downto 10)="000101" then
				res<="111010";
			end if;
			if I(15 downto 10)="000110" then
				res<="111001";
			end if;
			if I(15 downto 10)="000111" then
				res<="111000";
			end if;
			if I(15 downto 10)="001000" then
				res<="110111";
			end if;
			if I(15 downto 10)="001001" then
				res<="110110";
			end if;
			if I(15 downto 10)="001010" then
				res<="110101";
			end if;
			if I(15 downto 10)="001011" then
				res<="110100";
			end if;
			if I(15 downto 10)="001100" then
				res<="110011";
			end if;
			if I(15 downto 10)="001101" then
				res<="110010";
			end if;
			if I(15 downto 10)="001110" then
				res<="110001";
			end if;
			if I(15 downto 10)="001111" then
				res<="110000";
			end if;
			if I(15 downto 10)="010000" then
				res<="101111";
			end if;
			if I(15 downto 10)="010001" then
				res<="101110";
			end if;
			if I(15 downto 10)="010010" then
				res<="101101";
			end if;
			if I(15 downto 10)="010011" then
				res<="101100";
			end if;
			if I(15 downto 10)="010100" then
				res<="101011";
			end if;
			if I(15 downto 10)="010101" then
				res<="101010";
			end if;
			if I(15 downto 10)="010110" then
				res<="101001";
			end if;
			if I(15 downto 10)="010111" then
				res<="101000";
			end if;
			if I(15 downto 10)="011000" then
				res<="100111";
			end if;
			if I(15 downto 10)="011001" then
				res<="100110";
			end if;
			if I(15 downto 10)="011010" then
				res<="100101";
			end if;
			if I(15 downto 10)="011011" then
				res<="100100";
			end if;
			if I(15 downto 10)="011100" then
				res<="100011";
			end if;
			if I(15 downto 10)="011101" then
				res<="100010";
			end if;
			if I(15 downto 10)="011110" then
				res<="100001";
			end if;
			if I(15 downto 10)="011111" then
				res<="100000";
			end if;
			if I(15 downto 10)="100000" then
				res<="011111";
			end if;
			if I(15 downto 10)="100001" then
				res<="011110";
			end if;
			if I(15 downto 10)="100010" then
				res<="011101";
			end if;
			if I(15 downto 10)="100011" then
				res<="011100";
			end if;
			if I(15 downto 10)="100100" then
				res<="011011";
			end if;
			if I(15 downto 10)="100101" then
				res<="011010";
			end if;
			if I(15 downto 10)="100110" then
				res<="011001";
			end if;
			if I(15 downto 10)="100111" then
				res<="011000";
			end if;
			if I(15 downto 10)="101000" then
				res<="010111";
			end if;
			if I(15 downto 10)="101001" then
				res<="010110";
			end if;
			if I(15 downto 10)="101010" then
				res<="010101";
			end if;
			if I(15 downto 10)="101011" then
				res<="010100";
			end if;
			if I(15 downto 10)="101100" then
				res<="010011";
			end if;
			if I(15 downto 10)="101101" then
				res<="010010";
			end if;
			if I(15 downto 10)="101110" then
				res<="010001";
			end if;
			if I(15 downto 10)="101111" then
				res<="010000";
			end if;
			if I(15 downto 10)="110000" then
				res<="001111";
			end if;
			if I(15 downto 10)="110001" then
				res<="001110";
			end if;
			if I(15 downto 10)="110010" then
				res<="001101";
			end if;
			if I(15 downto 10)="110011" then
				res<="001100";
			end if;
			if I(15 downto 10)="110100" then
				res<="001011";
			end if;
			if I(15 downto 10)="110101" then
				res<="001010";
			end if;
			if I(15 downto 10)="110110" then
				res<="001001";
			end if;
			if I(15 downto 10)="110111" then
				res<="001000";
			end if;
			if I(15 downto 10)="111000" then
				res<="000111";
			end if;
			if I(15 downto 10)="111001" then
				res<="000110";
			end if;
			if I(15 downto 10)="111010" then
				res<="000101";
			end if;
			if I(15 downto 10)="111011" then
				res<="000100";
			end if;
			if I(15 downto 10)="111100" then
				res<="000011";
			end if;
			if I(15 downto 10)="111101" then
				res<="000010";
			end if;
			if I(15 downto 10)="111110" then
				res<="000001";
			end if;
			if I(15 downto 10)="111111" then
				res<="000000";
			end if;
		elsif P(2)='1' then
			if I(13 downto 12)="00" then
				res<="111111";
			elsif I(13 downto 12)="01" then
				res<="111110";
			elsif I(13 downto 12)="10" then
				res<="111101";
			else
				res<="111100";
			end if;
		elsif P(3)='1' then
			
		else
			res<="111111";
		end if;
	else
		res<="111111";
	end if;
	
	SE <= res;

end process;

END behav;