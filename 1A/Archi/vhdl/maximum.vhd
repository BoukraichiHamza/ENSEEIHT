library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity maximum is
	port (
		rst : in std_logic ;
		h : in std_logic ;
		val : in std_logic_vector (3 downto 0) ;
		max : out std_logic_vector (3 downto 0)
	);
end maximum;

architecture synthesis of maximum is

	-- submodules declarations
	component ucmp4
		port (
			a : in std_logic_vector (3 downto 0) ;
			b : in std_logic_vector (3 downto 0) ;
			sup : out std_logic ;
			eq : out std_logic
		) ;
	end component ;

	-- buffer signals declarations
	signal max_int : std_logic_vector (3 downto 0) ;

	-- internal signals declarations
	signal sup : std_logic ;
	signal eq : std_logic ;

begin

	-- buffer signals assignations
	max(3 downto 0) <= max_int(3 downto 0) ;

	-- sequential statements
	process (h, rst) begin
		if rst = '1' then
			max_int(3 downto 0) <= "0000" ;
		elsif sup = '1' and h'event and h = '1' then
			max_int(3 downto 0) <= val(3 downto 0) ;
		end if ;
	end process ;

	-- components instanciations
	ucmp4_0 : ucmp4 port map (val(3 downto 0), max_int(3 downto 0), sup, eq) ;

end synthesis;
