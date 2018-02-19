library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testclock28 is
	port (
		rst : in std_logic ;
		mclk : in std_logic ;
		s : out std_logic_vector (27 downto 0) ;
		ld : out std_logic_vector (7 downto 0)
	);
end testclock28;

architecture synthesis of testclock28 is

	-- submodules declarations
	component clock28
		port (
			rst : in std_logic ;
			h : in std_logic ;
			s : out std_logic_vector (27 downto 0)
		) ;
	end component ;

	-- buffer signals declarations
	signal s_int : std_logic_vector (27 downto 0) ;

begin

	-- buffer signals assignations
	s(27 downto 0) <= s_int(27 downto 0) ;

	-- concurrent statements
	ld(7 downto 0) <= s_int(27 downto 20) ;

	-- components instanciations
	clock28_0 : clock28 port map (rst, mclk, s_int(27 downto 0)) ;

end synthesis;
