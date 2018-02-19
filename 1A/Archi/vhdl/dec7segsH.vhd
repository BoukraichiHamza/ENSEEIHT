library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dec7segsH is
	port (
		x : in std_logic_vector (3 downto 0) ;
		seg : out std_logic_vector (6 downto 0)
	);
end dec7segsH;

architecture synthesis of dec7segsH is

	-- submodules declarations
	component decoder4to16
		port (
			e : in std_logic_vector (3 downto 0) ;
			s : out std_logic_vector (15 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal dec : std_logic_vector (15 downto 0) ;

begin

	-- concurrent statements
	seg(0) <= (not dec(1)) and (not dec(4)) and (not dec(11)) and (not dec(13)) ;
	seg(1) <= (not dec(5)) and (not dec(6)) and (not dec(11)) and (not dec(12)) and (not dec(15)) ;
	seg(2) <= (not dec(2)) and (not dec(12)) and (not dec(14)) and (not dec(15)) ;
	seg(3) <= (not dec(1)) and (not dec(4)) and (not dec(7)) and (not dec(15)) ;
	seg(4) <= (not dec(1)) and (not dec(3)) and (not dec(4)) and (not dec(5)) and (not dec(7)) and (not dec(9)) ;
	seg(5) <= (not dec(1)) and (not dec(2)) and (not dec(3)) and (not dec(7)) and (not dec(10)) and (not dec(13)) ;
	seg(6) <= (not dec(0)) and (not dec(1)) and (not dec(7)) and (not dec(12)) ;

	-- components instanciations
	decoder4to16_0 : decoder4to16 port map (x(3 downto 0), dec(15 downto 0)) ;

end synthesis;
