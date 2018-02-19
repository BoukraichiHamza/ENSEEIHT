library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity affmux is
	port (
		rst : in std_logic ;
		h : in std_logic ;
		data : in std_logic_vector (15 downto 0) ;
		anodes : out std_logic_vector (3 downto 0) ;
		seg : out std_logic_vector (6 downto 0)
	);
end affmux;

architecture synthesis of affmux is

	-- submodules declarations
	component dec7segsH
		port (
			x : in std_logic_vector (3 downto 0) ;
			seg : out std_logic_vector (6 downto 0)
		) ;
	end component ;
	component clock28
		port (
			rst : in std_logic ;
			h : in std_logic ;
			s : out std_logic_vector (27 downto 0)
		) ;
	end component ;
	component decoder2to4
		port (
			e : in std_logic_vector (1 downto 0) ;
			s : out std_logic_vector (3 downto 0)
		) ;
	end component ;

	-- internal signals declarations
	signal seg0 : std_logic_vector (6 downto 0) ;
	signal seg1 : std_logic_vector (6 downto 0) ;
	signal seg2 : std_logic_vector (6 downto 0) ;
	signal seg3 : std_logic_vector (6 downto 0) ;
	signal s : std_logic_vector (27 downto 0) ;
	signal dec : std_logic_vector (3 downto 0) ;

begin

	-- concurrent statements
	seg(6 downto 0) <= 
		(not seg3(6 downto 0) and (dec(3)&dec(3)&dec(3)&dec(3)&dec(3)&dec(3)&dec(3))) or
		(not seg2(6 downto 0) and (dec(2)&dec(2)&dec(2)&dec(2)&dec(2)&dec(2)&dec(2))) or
		(not seg1(6 downto 0) and (dec(1)&dec(1)&dec(1)&dec(1)&dec(1)&dec(1)&dec(1))) or
		(not seg0(6 downto 0) and (dec(0)&dec(0)&dec(0)&dec(0)&dec(0)&dec(0)&dec(0))) ;
	anodes(3 downto 0) <= not dec(3 downto 0) ;

	-- components instanciations
	dec7segsH_0 : dec7segsH port map (data(3 downto 0), seg0(6 downto 0)) ;
	dec7segsH_1 : dec7segsH port map (data(7 downto 4), seg1(6 downto 0)) ;
	dec7segsH_2 : dec7segsH port map (data(11 downto 8), seg2(6 downto 0)) ;
	dec7segsH_3 : dec7segsH port map (data(15 downto 12), seg3(6 downto 0)) ;
	clock28_4 : clock28 port map (rst, h, s(27 downto 0)) ;
	decoder2to4_5 : decoder2to4 port map (s(15 downto 14), dec(3 downto 0)) ;

end synthesis;
