library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder32 is
	port (
		a : in std_logic_vector (31 downto 0) ;
		b : in std_logic_vector (31 downto 0) ;
		cin : in std_logic ;
		s : out std_logic_vector (31 downto 0) ;
		cout : out std_logic
	);
end adder32;

architecture synthesis of adder32 is

	-- submodules declarations
	component adder16
		port (
			a : in std_logic_vector (15 downto 0) ;
			b : in std_logic_vector (15 downto 0) ;
			cin : in std_logic ;
			s : out std_logic_vector (15 downto 0) ;
			cout : out std_logic
		) ;
	end component ;

	-- internal signals declarations
	signal c0 : std_logic ;

begin

	-- components instanciations
	adder16_0 : adder16 port map (a(15 downto 0), b(15 downto 0), cin, s(15 downto 0), c0) ;
	adder16_1 : adder16 port map (a(31 downto 16), b(31 downto 16), c0, s(31 downto 16), cout) ;

end synthesis;
