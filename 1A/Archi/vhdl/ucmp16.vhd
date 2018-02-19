library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ucmp16 is
	port (
		a : in std_logic_vector (15 downto 0) ;
		b : in std_logic_vector (15 downto 0) ;
		sup : out std_logic ;
		eq : out std_logic
	);
end ucmp16;

architecture synthesis of ucmp16 is

	-- submodules declarations
	component ucmp8
		port (
			a : in std_logic_vector (7 downto 0) ;
			b : in std_logic_vector (7 downto 0) ;
			sup : out std_logic ;
			eq : out std_logic
		) ;
	end component ;

	-- internal signals declarations
	signal supaux1 : std_logic ;
	signal eqaux1 : std_logic ;
	signal supaux0 : std_logic ;
	signal eqaux0 : std_logic ;

begin

	-- concurrent statements
	sup <= (supaux1) or (eqaux1 and supaux0) ;
	eq <= eqaux1 and eqaux0 ;

	-- components instanciations
	ucmp8_0 : ucmp8 port map (a(15 downto 8), b(15 downto 8), supaux1, eqaux1) ;
	ucmp8_1 : ucmp8 port map (a(7 downto 0), b(7 downto 0), supaux0, eqaux0) ;

end synthesis;
