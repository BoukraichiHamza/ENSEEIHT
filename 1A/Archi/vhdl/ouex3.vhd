library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ouex3 is
	port (
		a : in std_logic ;
		b : in std_logic ;
		c : in std_logic ;
		s : out std_logic
	);
end ouex3;

architecture synthesis of ouex3 is

	-- internal signals declarations
	signal aux : std_logic ;

begin

	-- concurrent statements
	aux <= (a and (not b)) or ((not a) and b) ;
	s <= (c and (not aux)) or ((not c) and aux) ;

end synthesis;
