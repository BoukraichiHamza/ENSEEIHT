library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock28 is
	port (
		rst : in std_logic ;
		h : in std_logic ;
		s : out std_logic_vector (27 downto 0)
	);
end clock28;

architecture synthesis of clock28 is

	-- submodules declarations
	component clock4
		port (
			rst : in std_logic ;
			h : in std_logic ;
			s : out std_logic_vector (3 downto 0)
		) ;
	end component ;

	-- buffer signals declarations
	signal s_int : std_logic_vector (27 downto 0) ;

begin

	-- buffer signals assignations
	s(27 downto 0) <= s_int(27 downto 0) ;

	-- components instanciations
	clock4_0 : clock4 port map (rst, h, s_int(3 downto 0)) ;
	clock4_1 : clock4 port map (rst, s_int(3), s_int(7 downto 4)) ;
	clock4_2 : clock4 port map (rst, s_int(7), s_int(11 downto 8)) ;
	clock4_3 : clock4 port map (rst, s_int(11), s_int(15 downto 12)) ;
	clock4_4 : clock4 port map (rst, s_int(15), s_int(19 downto 16)) ;
	clock4_5 : clock4 port map (rst, s_int(19), s_int(23 downto 20)) ;
	clock4_6 : clock4 port map (rst, s_int(23), s_int(27 downto 24)) ;

end synthesis;
