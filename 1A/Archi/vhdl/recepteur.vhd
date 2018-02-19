library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity recepteur is
	port (
		dr4 : in std_logic ;
		dr3 : in std_logic ;
		dr2 : in std_logic ;
		cr3 : in std_logic ;
		dr1 : in std_logic ;
		cr2 : in std_logic ;
		cr1 : in std_logic ;
		err : out std_logic ;
		d4 : out std_logic ;
		d3 : out std_logic ;
		d2 : out std_logic ;
		d1 : out std_logic
	);
end recepteur;

architecture synthesis of recepteur is

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
	component decoder3to8
		port (
			e : in std_logic_vector (2 downto 0) ;
			s : out std_logic_vector (7 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal c3 : std_logic ;
	signal c2 : std_logic ;
	signal c1 : std_logic ;
	signal poserr : std_logic_vector (2 downto 0) ;
	signal derr : std_logic_vector (7 downto 0) ;

begin

	-- concurrent statements
	poserr(2) <= (cr3 and (not c3)) or ((not cr3) and c3) ;
	poserr(1) <= (cr2 and (not c2)) or ((not cr2) and c2) ;
	poserr(0) <= (cr1 and (not c1)) or ((not cr1) and c1) ;
	err <= not derr(0) ;
	d4 <= (dr4 and (not derr(7))) or ((not dr4) and derr(7)) ;
	d3 <= (dr3 and (not derr(6))) or ((not dr3) and derr(6)) ;
	d2 <= (dr2 and (not derr(5))) or ((not dr2) and derr(5)) ;
	d1 <= (dr1 and (not derr(3))) or ((not dr1) and derr(3)) ;

	-- components instanciations
	bits_ctrl_0 : bits_ctrl port map (dr4, dr3, dr2, dr1, c3, c2, c1) ;
	decoder3to8_1 : decoder3to8 port map (poserr(2 downto 0), derr(7 downto 0)) ;

end synthesis;
