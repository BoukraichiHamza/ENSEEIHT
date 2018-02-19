library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eq32 is
	port (
		a : in std_logic_vector (31 downto 0) ;
		b : in std_logic_vector (31 downto 0) ;
		equal : out std_logic
	);
end eq32;

architecture synthesis of eq32 is

	-- submodules declarations
	component eq8
		port (
			a : in std_logic_vector (7 downto 0) ;
			b : in std_logic_vector (7 downto 0) ;
			equal : out std_logic
		) ;
	end component ;

	-- internal signals declarations
	signal eq0 : std_logic ;
	signal eq1 : std_logic ;
	signal eq2 : std_logic ;
	signal eq3 : std_logic ;

begin

	-- concurrent statements
	equal <= eq0 and eq1 and eq2 and eq3 ;

	-- components instanciations
	eq8_0 : eq8 port map (a(7 downto 0), b(7 downto 0), eq0) ;
	eq8_1 : eq8 port map (a(15 downto 8), b(15 downto 8), eq1) ;
	eq8_2 : eq8 port map (a(23 downto 16), b(23 downto 16), eq2) ;
	eq8_3 : eq8 port map (a(31 downto 24), b(31 downto 24), eq3) ;

end synthesis;
