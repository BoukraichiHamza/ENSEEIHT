library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder3to8 is
	port (
		e : in std_logic_vector (2 downto 0) ;
		s : out std_logic_vector (7 downto 0)
	);
end decoder3to8;

architecture synthesis of decoder3to8 is

	-- submodules declarations
	component decoder2to4
		port (
			e : in std_logic_vector (1 downto 0) ;
			s : out std_logic_vector (3 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal aux : std_logic_vector (3 downto 0) ;

begin

	-- concurrent statements
	s(3 downto 0) <= 
		(aux(3 downto 0) and ((not e(2))&(not e(2))&(not e(2))&(not e(2)))) ;
	s(7 downto 4) <= 
		(aux(3 downto 0) and (e(2)&e(2)&e(2)&e(2))) ;

	-- components instanciations
	decoder2to4_0 : decoder2to4 port map (e(1 downto 0), aux(3 downto 0)) ;

end synthesis;
