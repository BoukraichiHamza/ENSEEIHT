library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity emetteur is
	port (
		d4 : in std_logic ;
		d3 : in std_logic ;
		d2 : in std_logic ;
		d1 : in std_logic ;
		de4 : out std_logic ;
		de3 : out std_logic ;
		de2 : out std_logic ;
		c3 : out std_logic ;
		de1 : out std_logic ;
		c2 : out std_logic ;
		c1 : out std_logic
	);
end emetteur;

architecture synthesis of emetteur is

	-- submodules declarations
	component bits_ctrl
		port (
			d4 : in std_logic ;
			d3 : in std_logic ;
			d2 : in std_logic ;
			d1 : in std_logic ;
			c3 : out std_logic ;
			c2 : out std_logic ;
			c1 : out std_logic
		) ;
	end component ;

begin

	-- concurrent statements
	de4 <= d4 ;
	de3 <= d3 ;
	de2 <= d2 ;
	de1 <= d1 ;

	-- components instanciations
	bits_ctrl_0 : bits_ctrl port map (d4, d3, d2, d1, c3, c2, c1) ;

end synthesis;
