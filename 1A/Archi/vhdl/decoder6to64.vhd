library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder6to64 is
	port (
		e : in std_logic_vector (5 downto 0) ;
		s : out std_logic_vector (63 downto 0)
	);
end decoder6to64;

architecture synthesis of decoder6to64 is

	-- submodules declarations
	component decoder5to32
		port (
			e : in std_logic_vector (4 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal aux : std_logic_vector (31 downto 0) ;

begin

	-- concurrent statements
	s(31 downto 0) <= 
		(aux(31 downto 0) and ((not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5))&(not e(5)))) ;
	s(63 downto 32) <= 
		(aux(31 downto 0) and (e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5)&e(5))) ;

	-- components instanciations
	decoder5to32_0 : decoder5to32 port map (e(4 downto 0), aux(31 downto 0)) ;

end synthesis;
