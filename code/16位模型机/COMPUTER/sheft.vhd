library ieee;
use ieee.std_logic_1164.all;

entity sheft is
	port(clk,m,c0:in std_logic;
		  s:in std_logic_vector(1 downto 0);
		  d:in std_logic_vector(15 downto 0);
		  q:out std_logic_vector(15 downto 0);
		 cn:out std_logic);
end entity;

architecture behav of sheft is
	signal abc:std_logic_vector(2 downto 0);
	
begin
	abc<=s&m;

	process(clk,s)
		variable reg8:std_logic_vector(15 downto 0);
		variable cy:std_logic;
	begin 

	if clk'event and clk ='1'then
		
		if abc="000" or abc="001" then
			reg8:=reg8;
		end if;

		if abc="010" then 
			cy:=reg8(15);
			reg8(15 downto 1) := reg8(14 downto 0);
			reg8(0):=cy;
		end if;

		if abc="011" then 
			cy:=c0;
			reg8(15 downto 1) := reg8(14 downto 0);
			reg8(0):=c0;
		end if;

		if abc="100" then
			cy:=reg8(0);
			reg8(14 downto 0) := reg8(15 downto 1);
			reg8(15):=cy;
		end if;

		if abc = "101" then
			cy:=c0;
			reg8(14 downto 0) := reg8(15 downto 1);
			reg8(15):=c0;
		end if;
		 
		if abc="110" or abc="111" then 
			reg8(15 downto 0) := d(15 downto 0);
		end if;
		
		q(15 downto 1)<= reg8(15 downto 1);
	end if;

	q(15 downto 0)<= reg8(15 downto 0);
	cn<=cy;

	end process;
end behav;