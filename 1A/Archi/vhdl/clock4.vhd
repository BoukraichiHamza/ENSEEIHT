library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock4 is
	port (
		rst : in std_logic ;
		h : in std_logic ;
		s : out std_logic_vector (3 downto 0)
	);
end clock4;

architecture synthesis of clock4 is

	-- buffer signals declarations
	signal s_int : std_logic_vector (3 downto 0) ;

begin

	-- buffer signals assignations
	s(3 downto 0) <= s_int(3 downto 0) ;

	-- sequential statements
	process (h, rst) begin
		if rst = '1' then
			s_int(0) <= '0' ;
		elsif h'event and h = '0' then
			s_int(0) <= not s_int(0) ;
		end if ;
	end process ;
	process (s_int(0), rst) begin
		if rst = '1' then
			s_int(1) <= '0' ;
		elsif s_int(0)'event and s_int(0) = '0' then
			s_int(1) <= not s_int(1) ;
		end if ;
	end process ;
	process (s_int(1), rst) begin
		if rst = '1' then
			s_int(2) <= '0' ;
		elsif s_int(1)'event and s_int(1) = '0' then
			s_int(2) <= not s_int(2) ;
		end if ;
	end process ;
	process (s_int(2), rst) begin
		if rst = '1' then
			s_int(3) <= '0' ;
		elsif s_int(2)'event and s_int(2) = '0' then
			s_int(3) <= not s_int(3) ;
		end if ;
	end process ;

end synthesis;
