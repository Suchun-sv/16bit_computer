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
			if I(15 downto 14)="00" then
				if I(11 downto 10)="00" then
					res<="111111";
				end if;
				if I(11 downto 10)="01" then
					res<="111110";
				end if;
				if I(11 downto 10)="10" then
					res<="111101";
				end if;
				if I(11 downto 10)="11" then
					res<="111100";
				end if;
			elsif I(15 downto 14)="01" then
				if I(13 downto 12)="00" then
					res<="111011";
				end if;
				if I(13 downto 12)="01" then
					res<="111010";
				end if;
				if I(13 downto 12)="10" then
					res<="111001";
				end if;
				if I(13 downto 12)="11" then
					res<="111000";
				end if;
			elsif I(15 downto 14)="10" then
				if I(13 downto 12)="00" then
					res<="110111";
				end if;
				if I(13 downto 12)="01" then
					res<="110110";
				end if;
				if I(13 downto 12)="10" then
					res<="110101";
				end if;
				if I(13 downto 12)="11" then
					res<="110100";
				end if;
			elsif I(15 downto 14)="11" then
				if I(13 downto 12)="00" then
					res<="110011";
				end if;
				if I(13 downto 12)="01" then
					res<="110010";
				end if;
				if I(13 downto 12)="10" then
					res<="110001";
				end if;
				if I(13 downto 12)="11" then
					res<="110000";
				end if;
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