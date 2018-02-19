library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hamming is
	port (
		d4 : in std_logic ;
		d3 : in std_logic ;
		d2 : in std_logic ;
		d1 : in std_logic ;
		er : in std_logic_vector (6 downto 0) ;
		err : out std_logic ;
		dr4 : out std_logic ;
		dr3 : out std_logic ;
		dr2 : out std_logic ;
		dr1 : out std_logic
	);
end hamming;

architecture synthesis of hamming is

	-- submodules declarations
	component emetteur
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
		) ;
	end component ;
	component recepteur
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
		) ;
	end component ;

	-- internal signals declarations
	signal s1 : std_logic_vector (6 downto 0) ;
	signal s : std_logic_vector (6 downto 0) ;

begin

	-- concurrent statements
	s(6 downto 0) <= (s1(6 downto 0) and (not er(6 downto 0))) or ((not s1(6 downto 0)) and er(6 downto 0)) ;

	-- components instanciations
	emetteur_0 : emetteur port map (d4, d3, d2, d1, s1(6), s1(5), s1(4), s1(3), s1(2), s1(1), s1(0)) ;
	recepteur_1 : recepteur port map (s(6), s(5), s(4), s(3), s(2), s(1), s(0), err, dr4, dr3, dr2, dr1) ;

end synthesis;
