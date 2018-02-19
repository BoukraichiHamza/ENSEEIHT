library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder4to16 is
	port (
		e : in std_logic_vector (3 downto 0) ;
		s : out std_logic_vector (15 downto 0)
	);
end decoder4to16;

architecture synthesis of decoder4to16 is

	-- submodules declarations
	component decoder3to8
		port (
			e : in std_logic_vector (2 downto 0) ;
			s : out std_logic_vector (7 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal aux : std_logic_vector (7 downto 0) ;

begin

	-- concurrent statements
	s(7 downto 0) <= 
		(aux(7 downto 0) and ((not e(3))&(not e(3))&(not e(3))&(not e(3))&(not e(3))&(not e(3))&(not e(3))&(not e(3)))) ;
	s(15 downto 8) <= 
		(aux(7 downto 0) and (e(3)&e(3)&e(3)&e(3)&e(3)&e(3)&e(3)&e(3))) ;

	-- components instanciations
	decoder3to8_0 : decoder3to8 port map (e(2 downto 0), aux(7 downto 0)) ;

end synthesis;
