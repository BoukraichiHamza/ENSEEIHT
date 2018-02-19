library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addsub32 is
	port (
		a : in std_logic_vector (31 downto 0) ;
		b : in std_logic_vector (31 downto 0) ;
		sub : in std_logic ;
		s : out std_logic_vector (31 downto 0) ;
		v : out std_logic ;
		c : out std_logic
	);
end addsub32;

architecture synthesis of addsub32 is

	-- submodules declarations
	component adder32
		port (
			a : in std_logic_vector (31 downto 0) ;
			b : in std_logic_vector (31 downto 0) ;
			cin : in std_logic ;
			s : out std_logic_vector (31 downto 0) ;
			cout : out std_logic
		) ;
	end component ;

	-- buffer signals declarations
	signal s_int : std_logic_vector (31 downto 0) ;

	-- internal signals declarations
	signal auxb : std_logic_vector (31 downto 0) ;
	signal cout : std_logic ;
	signal vadd : std_logic ;
	signal vsub : std_logic ;

begin

	-- buffer signals assignations
	s(31 downto 0) <= s_int(31 downto 0) ;

	-- concurrent statements
	auxb(31 downto 0) <= 
		(b(31 downto 0) and ((not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub)&(not sub))) or
		(not b(31 downto 0) and (sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub&sub)) ;
	c <= ((not sub) and cout) or (sub and (not cout)) ;
	vadd <= ((not a(31)) and (not b(31)) and s_int(31)) or (a(31) and b(31) and (not s_int(31))) ;
	vsub <= ((not a(31)) and b(31) and s_int(31)) or (a(31) and (not b(31)) and (not s_int(31))) ;
	v <= ((not sub) and vadd) or (sub and vsub) ;

	-- components instanciations
	adder32_0 : adder32 port map (a(31 downto 0), auxb(31 downto 0), sub, s_int(31 downto 0), cout) ;

end synthesis;
