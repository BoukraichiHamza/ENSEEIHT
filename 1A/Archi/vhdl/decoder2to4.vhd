library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder2to4 is
	port (
		e : in std_logic_vector (1 downto 0) ;
		s : out std_logic_vector (3 downto 0)
	);
end decoder2to4;

architecture synthesis of decoder2to4 is

begin

	-- concurrent statements
	s(0) <= (not e(0)) and (not e(1)) ;
	s(1) <= e(0) and (not e(1)) ;
	s(2) <= (not e(0)) and e(1) ;
	s(3) <= e(0) and e(1) ;

end synthesis;
