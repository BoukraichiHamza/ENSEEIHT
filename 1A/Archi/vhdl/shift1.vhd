library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift1 is
	port (
		r : in std_logic ;
		en : in std_logic ;
		e : in std_logic_vector (31 downto 0) ;
		s : out std_logic_vector (31 downto 0)
	);
end shift1;

architecture synthesis of shift1 is

	-- internal signals declarations
	signal auxshiftd : std_logic_vector (31 downto 0) ;
	signal auxshiftg : std_logic_vector (31 downto 0) ;
	signal auxshift : std_logic_vector (31 downto 0) ;

begin

	-- concurrent statements
	auxshiftd(30 downto 0) <= e(31 downto 1) ;
	auxshiftd(31) <= '0' ;
	auxshiftg(31 downto 1) <= e(30 downto 0) ;
	auxshiftg(0) <= '0' ;
	auxshift(31 downto 0) <= 
		(auxshiftd(31 downto 0) and (r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r&r)) or
		(auxshiftg(31 downto 0) and ((not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r)&(not r))) ;
	s(31 downto 0) <= 
		(e(31 downto 0) and ((not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en)&(not en))) or
		(auxshift(31 downto 0) and (en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en&en)) ;

end synthesis;
