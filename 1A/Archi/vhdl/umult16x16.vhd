library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

-- multiplier

entity umult16x16 is
	port (
		arg1  : in std_logic_vector(15 downto 0);
		arg2  : in std_logic_vector(15 downto 0);
		res  : out std_logic_vector(31 downto 0)
	) ;
end umult16x16 ;

architecture synthesis of umult16x16 is

begin
	res <= arg1 * arg2 ;

end synthesis ;
