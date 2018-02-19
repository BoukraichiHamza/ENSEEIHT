library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder8 is
	port (
		a : in std_logic_vector (7 downto 0) ;
		b : in std_logic_vector (7 downto 0) ;
		cin : in std_logic ;
		s : out std_logic_vector (7 downto 0) ;
		cout : out std_logic
	);
end adder8;

architecture synthesis of adder8 is

	-- submodules declarations
	component adder4
		port (
			a : in std_logic_vector (3 downto 0) ;
			b : in std_logic_vector (3 downto 0) ;
			cin : in std_logic ;
			s : out std_logic_vector (3 downto 0) ;
			cout : out std_logic
		) ;
	end component ;

	-- internal signals declarations
	signal c0 : std_logic ;

begin

	-- components instanciations
	adder4_0 : adder4 port map (a(3 downto 0), b(3 downto 0), cin, s(3 downto 0), c0) ;
	adder4_1 : adder4 port map (a(7 downto 4), b(7 downto 4), c0, s(7 downto 4), cout) ;

end synthesis;
