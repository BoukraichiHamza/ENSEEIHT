library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift8 is
	port (
		r : in std_logic ;
		en : in std_logic ;
		e : in std_logic_vector (31 downto 0) ;
		s : out std_logic_vector (31 downto 0)
	);
end shift8;

architecture synthesis of shift8 is

	-- submodules declarations
	component shift4
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
	shift4_0 : shift4 port map (r, en, e(31 downto 0), s0(31 downto 0)) ;
	shift4_1 : shift4 port map (r, en, s0(31 downto 0), s(31 downto 0)) ;

end synthesis;
