library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test7seg is
	port (
		sw : in std_logic_vector (3 downto 0) ;
		ssg : out std_logic_vector (6 downto 0) ;
		an : out std_logic_vector (3 downto 0)
	);
end test7seg;

architecture synthesis of test7seg is

	-- submodules declarations
	component dec7segsH
		port (
			x : in std_logic_vector (3 downto 0) ;
			seg : out std_logic_vector (6 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal aux : std_logic_vector (6 downto 0) ;

begin

	-- concurrent statements
	ssg(6 downto 0) <= not aux(6 downto 0) ;
	an(3 downto 0) <= "1110" ;

	-- components instanciations
	dec7segsH_0 : dec7segsH port map (sw(3 downto 0), aux(6 downto 0)) ;

end synthesis;
