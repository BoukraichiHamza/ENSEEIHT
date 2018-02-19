library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder5to32 is
	port (
		e : in std_logic_vector (4 downto 0) ;
		s : out std_logic_vector (31 downto 0)
	);
end decoder5to32;

architecture synthesis of decoder5to32 is

	-- submodules declarations
	component decoder4to16
		port (
			e : in std_logic_vector (3 downto 0) ;
			s : out std_logic_vector (15 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal aux : std_logic_vector (15 downto 0) ;

begin

	-- concurrent statements
	s(15 downto 0) <= 
		(aux(15 downto 0) and ((not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4))&(not e(4)))) ;
	s(31 downto 16) <= 
		(aux(15 downto 0) and (e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4)&e(4))) ;

	-- components instanciations
	decoder4to16_0 : decoder4to16 port map (e(3 downto 0), aux(15 downto 0)) ;

end synthesis;
