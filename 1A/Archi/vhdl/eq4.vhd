library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eq4 is
	port (
		a : in std_logic_vector (3 downto 0) ;
		b : in std_logic_vector (3 downto 0) ;
		equal : out std_logic
	);
end eq4;

architecture synthesis of eq4 is

	-- internal signals declarations
	signal eq : std_logic_vector (3 downto 0) ;

begin

	-- concurrent statements
	eq(3 downto 0) <= (a(3 downto 0) and b(3 downto 0)) or ((not a(3 downto 0)) and (not b(3 downto 0))) ;
	equal <= eq(3) and eq(2) and eq(1) and eq(0) ;

end synthesis;
