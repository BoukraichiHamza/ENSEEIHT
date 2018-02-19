library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testaffmux is
	port (
		rst : in std_logic ;
		mclk : in std_logic ;
		data : in std_logic_vector (15 downto 0) ;
		an : out std_logic_vector (3 downto 0) ;
		ssg : out std_logic_vector (6 downto 0)
	);
end testaffmux;

architecture synthesis of testaffmux is

	-- submodules declarations
	component affmux
		port (
			rst : in std_logic ;
			h : in std_logic ;
			data : in std_logic_vector (15 downto 0) ;
			anodes : out std_logic_vector (3 downto 0) ;
			seg : out std_logic_vector (6 downto 0)
		) ;
	end component ;

begin

	-- components instanciations
	affmux_0 : affmux port map (rst, mclk, data(15 downto 0), an(3 downto 0), ssg(6 downto 0)) ;

end synthesis;
