library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registres is
	port (
		rst : in std_logic ;
		clk : in std_logic ;
		areg : in std_logic_vector (4 downto 0) ;
		breg : in std_logic_vector (4 downto 0) ;
		dreg : in std_logic_vector (4 downto 0) ;
		dbus : in std_logic_vector (31 downto 0) ;
		abus : inout std_logic_vector (31 downto 0) ;
		bbus : inout std_logic_vector (31 downto 0) ;
		ir : out std_logic_vector (31 downto 0) ;
		break : out std_logic
	);
end registres;

architecture synthesis of registres is

	-- submodules declarations
	component decoder5to32
		port (
			e : in std_logic_vector (4 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;
	component reg32
		port (
			rst : in std_logic ;
			clk : in std_logic ;
			en : in std_logic ;
			d : in std_logic_vector (31 downto 0) ;
			q : out std_logic_vector (31 downto 0)
		) ;
	end component ;
	component eq32
		port (
			a : in std_logic_vector (31 downto 0) ;
			b : in std_logic_vector (31 downto 0) ;
			equal : out std_logic
		) ;
	end component ;

	-- buffer signals declarations
	signal ir_int : std_logic_vector (31 downto 0) ;

	-- internal signals declarations
	signal deca : std_logic_vector (31 downto 0) ;
	signal decb : std_logic_vector (31 downto 0) ;
	signal decc : std_logic_vector (31 downto 0) ;
	signal r1 : std_logic_vector (31 downto 0) ;
	signal r2 : std_logic_vector (31 downto 0) ;
	signal r3 : std_logic_vector (31 downto 0) ;
	signal r4 : std_logic_vector (31 downto 0) ;
	signal r5 : std_logic_vector (31 downto 0) ;
	signal r6 : std_logic_vector (31 downto 0) ;
	signal r7 : std_logic_vector (31 downto 0) ;
	signal r8 : std_logic_vector (31 downto 0) ;
	signal r9 : std_logic_vector (31 downto 0) ;
	signal tmp1 : std_logic_vector (31 downto 0) ;
	signal tmp2 : std_logic_vector (31 downto 0) ;
	signal brk : std_logic_vector (31 downto 0) ;
	signal fp : std_logic_vector (31 downto 0) ;
	signal ret : std_logic_vector (31 downto 0) ;
	signal sp : std_logic_vector (31 downto 0) ;
	signal pc : std_logic_vector (31 downto 0) ;

begin

	-- buffer signals assignations
	ir(31 downto 0) <= ir_int(31 downto 0) ;

	-- concurrent statements
	abus(31 downto 0) <= "00000000000000000000000000000000" when deca(0) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r1(31 downto 0) when deca(1) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r2(31 downto 0) when deca(2) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r3(31 downto 0) when deca(3) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r4(31 downto 0) when deca(4) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r5(31 downto 0) when deca(5) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r6(31 downto 0) when deca(6) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r7(31 downto 0) when deca(7) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r8(31 downto 0) when deca(8) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= r9(31 downto 0) when deca(9) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= "00000000000000000000000000000001" when deca(20) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= tmp1(31 downto 0) when deca(21) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= tmp2(31 downto 0) when deca(22) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= brk(31 downto 0) when deca(26) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= fp(31 downto 0) when deca(27) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= ret(31 downto 0) when deca(28) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= sp(31 downto 0) when deca(29) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= pc(31 downto 0) when deca(30) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	abus(31 downto 0) <= ir_int(31 downto 0) when deca(31) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= "00000000000000000000000000000000" when decb(0) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r1(31 downto 0) when decb(1) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r2(31 downto 0) when decb(2) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r3(31 downto 0) when decb(3) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r4(31 downto 0) when decb(4) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r5(31 downto 0) when decb(5) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r6(31 downto 0) when decb(6) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r7(31 downto 0) when decb(7) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r8(31 downto 0) when decb(8) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= r9(31 downto 0) when decb(9) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= "00000000000000000000000000000001" when decb(20) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= tmp1(31 downto 0) when decb(21) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= tmp2(31 downto 0) when decb(22) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= brk(31 downto 0) when decb(26) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= fp(31 downto 0) when decb(27) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= ret(31 downto 0) when decb(28) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= sp(31 downto 0) when decb(29) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= pc(31 downto 0) when decb(30) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	bbus(31 downto 0) <= ir_int(31 downto 0) when decb(31) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;

	-- components instanciations
	decoder5to32_0 : decoder5to32 port map (areg(4 downto 0), deca(31 downto 0)) ;
	decoder5to32_1 : decoder5to32 port map (breg(4 downto 0), decb(31 downto 0)) ;
	decoder5to32_2 : decoder5to32 port map (dreg(4 downto 0), decc(31 downto 0)) ;
	reg32_3 : reg32 port map (rst, clk, decc(1), dbus(31 downto 0), r1(31 downto 0)) ;
	reg32_4 : reg32 port map (rst, clk, decc(2), dbus(31 downto 0), r2(31 downto 0)) ;
	reg32_5 : reg32 port map (rst, clk, decc(3), dbus(31 downto 0), r3(31 downto 0)) ;
	reg32_6 : reg32 port map (rst, clk, decc(4), dbus(31 downto 0), r4(31 downto 0)) ;
	reg32_7 : reg32 port map (rst, clk, decc(5), dbus(31 downto 0), r5(31 downto 0)) ;
	reg32_8 : reg32 port map (rst, clk, decc(6), dbus(31 downto 0), r6(31 downto 0)) ;
	reg32_9 : reg32 port map (rst, clk, decc(7), dbus(31 downto 0), r7(31 downto 0)) ;
	reg32_10 : reg32 port map (rst, clk, decc(8), dbus(31 downto 0), r8(31 downto 0)) ;
	reg32_11 : reg32 port map (rst, clk, decc(9), dbus(31 downto 0), r9(31 downto 0)) ;
	reg32_12 : reg32 port map (rst, clk, decc(21), dbus(31 downto 0), tmp1(31 downto 0)) ;
	reg32_13 : reg32 port map (rst, clk, decc(22), dbus(31 downto 0), tmp2(31 downto 0)) ;
	reg32_14 : reg32 port map (rst, clk, decc(26), dbus(31 downto 0), brk(31 downto 0)) ;
	reg32_15 : reg32 port map (rst, clk, decc(27), dbus(31 downto 0), fp(31 downto 0)) ;
	reg32_16 : reg32 port map (rst, clk, decc(28), dbus(31 downto 0), ret(31 downto 0)) ;
	reg32_17 : reg32 port map (rst, clk, decc(29), dbus(31 downto 0), sp(31 downto 0)) ;
	reg32_18 : reg32 port map (rst, clk, decc(30), dbus(31 downto 0), pc(31 downto 0)) ;
	reg32_19 : reg32 port map (rst, clk, decc(31), dbus(31 downto 0), ir_int(31 downto 0)) ;
	eq32_20 : eq32 port map (brk(31 downto 0), pc(31 downto 0), break) ;

end synthesis;
