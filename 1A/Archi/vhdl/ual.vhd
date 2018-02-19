library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ual is
	port (
		a : in std_logic_vector (31 downto 0) ;
		b : in std_logic_vector (31 downto 0) ;
		cmd : in std_logic_vector (5 downto 0) ;
		s : out std_logic_vector (31 downto 0) ;
		en : out std_logic ;
		ez : out std_logic ;
		evc : out std_logic ;
		n : out std_logic ;
		z : out std_logic ;
		v : out std_logic ;
		c : out std_logic
	);
end ual;

architecture synthesis of ual is

	-- submodules declarations
	component addsub32
		port (
			a : in std_logic_vector (31 downto 0) ;
			b : in std_logic_vector (31 downto 0) ;
			sub : in std_logic ;
			s : out std_logic_vector (31 downto 0) ;
			v : out std_logic ;
			c : out std_logic
		) ;
	end component ;
	component barrelshifter32
		port (
			r : in std_logic ;
			nb : in std_logic_vector (4 downto 0) ;
			e : in std_logic_vector (31 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;
	component umult16x16
		port (
			arg1  : in std_logic_vector(15 downto 0);
			arg2  : in std_logic_vector(15 downto 0);
			res  : out std_logic_vector(31 downto 0)
		) ;
	end component ;
	component decoder6to64
		port (
			e : in std_logic_vector (5 downto 0) ;
			s : out std_logic_vector (63 downto 0)
		) ;
	end component ;
	component ucmp32
		port (
			a : in std_logic_vector (31 downto 0) ;
			b : in std_logic_vector (31 downto 0) ;
			sup : out std_logic ;
			eq : out std_logic
		) ;
	end component ;

	-- buffer signals declarations
	signal s_int : std_logic_vector (31 downto 0) ;

	-- internal signals declarations
	signal auxadd : std_logic_vector (31 downto 0) ;
	signal v1 : std_logic ;
	signal c1 : std_logic ;
	signal auxsub : std_logic_vector (31 downto 0) ;
	signal v2 : std_logic ;
	signal c2 : std_logic ;
	signal auxand : std_logic_vector (31 downto 0) ;
	signal auxor : std_logic_vector (31 downto 0) ;
	signal auxxor : std_logic_vector (31 downto 0) ;
	signal auxdecd : std_logic_vector (31 downto 0) ;
	signal auxdecg : std_logic_vector (31 downto 0) ;
	signal auxumult : std_logic_vector (31 downto 0) ;
	signal auxsethi : std_logic_vector (31 downto 0) ;
	signal signext13 : std_logic_vector (31 downto 0) ;
	signal signext25 : std_logic_vector (31 downto 0) ;
	signal commanddec : std_logic_vector (63 downto 0) ;
	signal sup : std_logic ;

begin

	-- buffer signals assignations
	s(31 downto 0) <= s_int(31 downto 0) ;

	-- concurrent statements
	auxand(31 downto 0) <= a(31 downto 0) and b(31 downto 0) ;
	auxor(31 downto 0) <= (a(31 downto 0)) or (b(31 downto 0)) ;
	auxxor(31 downto 0) <= ((not a(31 downto 0)) and b(31 downto 0)) or (a(31 downto 0) and (not b(31 downto 0))) ;
	auxsethi(7 downto 0) <= "00000000" ;
	auxsethi(31 downto 8) <= a(23 downto 0) ;
	signext13(12 downto 0) <= a(12 downto 0) ;
	signext13(31 downto 13) <= 
		("1111111111111111111" and (a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12)&a(12))) or
		("0000000000000000000" and ((not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12))&(not a(12)))) ;
	signext25(24 downto 0) <= a(24 downto 0) ;
	signext25(31 downto 25) <= 
		("1111111" and (a(24)&a(24)&a(24)&a(24)&a(24)&a(24)&a(24))) or
		("0000000" and ((not a(24))&(not a(24))&(not a(24))&(not a(24))&(not a(24))&(not a(24))&(not a(24)))) ;
	s_int(31 downto 0) <= 
		(auxadd(31 downto 0) and (commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0)&commanddec(0))) or
		(auxsub(31 downto 0) and (commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4)&commanddec(4))) or
		(auxand(31 downto 0) and (commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1)&commanddec(1))) or
		(auxor(31 downto 0) and (commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2)&commanddec(2))) or
		(auxxor(31 downto 0) and (commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3)&commanddec(3))) or
		(auxdecd(31 downto 0) and (commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13)&commanddec(13))) or
		(auxdecg(31 downto 0) and (commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14)&commanddec(14))) or
		(auxumult(31 downto 0) and (commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26)&commanddec(26))) or
		(auxadd(31 downto 0) and (commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16)&commanddec(16))) or
		(auxsub(31 downto 0) and (commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20)&commanddec(20))) or
		(auxor(31 downto 0) and (commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18)&commanddec(18))) or
		(auxand(31 downto 0) and (commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17)&commanddec(17))) or
		(auxxor(31 downto 0) and (commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19)&commanddec(19))) or
		(b(31 downto 0) and (commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40)&commanddec(40))) or
		(auxsethi(31 downto 0) and (commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35)&commanddec(35))) or
		(signext13(31 downto 0) and (commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32)&commanddec(32))) or
		(signext25(31 downto 0) and (commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33)&commanddec(33))) ;
	v <= (commanddec(0) and v1) or (commanddec(4) and v2) or (commanddec(16) and v1) or (commanddec(20) and v2) ;
	c <= (commanddec(0) and c1) or (commanddec(4) and c2) or (commanddec(16) and c1) or (commanddec(20) and c2) ;
	n <= s_int(31) ;
	en <= (commanddec(16)) or (commanddec(17)) or (commanddec(18)) or (commanddec(19)) or (commanddec(20)) ;
	ez <= (commanddec(16)) or (commanddec(17)) or (commanddec(18)) or (commanddec(19)) or (commanddec(20)) or (commanddec(26)) ;
	evc <= (commanddec(16)) or (commanddec(20)) ;

	-- components instanciations
	addsub32_0 : addsub32 port map (a(31 downto 0), b(31 downto 0), '0', auxadd(31 downto 0), v1, c1) ;
	addsub32_1 : addsub32 port map (a(31 downto 0), b(31 downto 0), '1', auxsub(31 downto 0), v2, c2) ;
	barrelshifter32_2 : barrelshifter32 port map ('1', b(4 downto 0), a(31 downto 0), auxdecd(31 downto 0)) ;
	barrelshifter32_3 : barrelshifter32 port map ('0', b(4 downto 0), a(31 downto 0), auxdecg(31 downto 0)) ;
	umult16x16_4 : umult16x16 port map (a(15 downto 0), b(15 downto 0), auxumult(31 downto 0)) ;
	decoder6to64_5 : decoder6to64 port map (cmd(5 downto 0), commanddec(63 downto 0)) ;
	ucmp32_6 : ucmp32 port map (s_int(31 downto 0), "00000000000000000000000000000000", sup, z) ;

end synthesis;
