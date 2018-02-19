library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ucmp1 is
	port (
		a : in std_logic ;
		b : in std_logic ;
		sup : out std_logic ;
		eq : out std_logic
	);
end ucmp1;

architecture synthesis of ucmp1 is

begin

	-- concurrent statements
	sup <= a and (not b) ;
	eq <= (a and b) or ((not a) and (not b)) ;

end synthesis;
