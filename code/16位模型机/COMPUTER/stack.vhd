library ieee;
use ieee.std_logic_1164.all;
Entity domo is
port(reset,push,pop,clk:in std_logic;
din:in std_logic_vector(7 downto 0);
empty,full:out std_logic;
dout:out std_logic_vector(7 downto 0));
end domo;
architecture a1 of domo is
type stack is array (15 downto 0) of std_logic_vector(7 downto 0);
begin
process(clk,reset)
variable s:  stack;
variable x: std_logic;
variable cnt: integer range 0 to 15;
begin
if reset='1' then
dout<="00000000"; x:='0'; cnt:=0;	
else
	if clk'event and clk='1' then
		if push='1' and pop='0' and x='0' then
			if cnt/=15 then 
				empty<='0'; s(cnt):=din; cnt:=cnt+1;
			else s(15):=din; x:='1';
			end if;
		elsif push='0' and pop='1' and cnt/=0 then
			if x='0' then 
				cnt:=cnt-1; dout<=s(cnt);
			else 
				dout<=s(15);  x:='0';
			end if;
		elsif cnt=0 then 
			empty<='1';
		end if;
	end if;
end if;
full<=x;
end process;
end a1;