library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eq8 is
	port (
		a : in std_logic_vector (7 downto 0) ;
		b : in std_logic_vector (7 downto 0) ;
		equal : out std_logic
	);
end eq8;

architecture synthesis of eq8 is

	-- internal signals declarations
	signal eq : std_logic_vector (7 downto 0) ;

begin

	-- concurrent statements
	eq(7 downto 0) <= ((not a(7 downto 0)) and (not b(7 downto 0))) or (a(7 downto 0) and b(7 downto 0)) ;
	equal <= eq(7) and eq(6) and eq(5) and eq(4) and eq(3) and eq(2) and eq(1) and eq(0) ;

end synthesis;
