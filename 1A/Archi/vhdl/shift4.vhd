library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift4 is
	port (
		r : in std_logic ;
		en : in std_logic ;
		e : in std_logic_vector (31 downto 0) ;
		s : out std_logic_vector (31 downto 0)
	);
end shift4;

architecture synthesis of shift4 is

	-- submodules declarations
	component shift2
		port (
			r : in std_logic ;
			en : in std_logic ;
			e : in std_logic_vector (31 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal s0 : std_logic_vector (31 downto 0) ;

begin

	-- components instanciations
	shift2_0 : shift2 port map (r, en, e(31 downto 0), s0(31 downto 0)) ;
	shift2_1 : shift2 port map (r, en, s0(31 downto 0), s(31 downto 0)) ;

end synthesis;
