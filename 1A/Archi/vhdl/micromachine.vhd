library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity micromachine is
	port (
		rst : in std_logic ;
		clk : in std_logic ;
		areg : in std_logic_vector (4 downto 0) ;
		breg : in std_logic_vector (4 downto 0) ;
		dreg : in std_logic_vector (4 downto 0) ;
		cmd_ual : in std_logic_vector (5 downto 0) ;
		oe_num : in std_logic_vector (1 downto 0) ;
		write : in std_logic ;
		monitor : in std_logic_vector (31 downto 0) ;
		switch : in std_logic_vector (7 downto 0) ;
		swclk : in std_logic ;
		dbus : inout std_logic_vector (31 downto 0) ;
		n : out std_logic ;
		z : out std_logic ;
		v : out std_logic ;
		c : out std_logic ;
		ir : out std_logic_vector (31 downto 0) ;
		break : out std_logic ;
		leds : out std_logic_vector (7 downto 0)
	);
end micromachine;

architecture synthesis of micromachine is

	-- submodules declarations
	component decoder2to4
		port (
			e : in std_logic_vector (1 downto 0) ;
			s : out std_logic_vector (3 downto 0)
		) ;
	end component ;
	component decoder4to16
		port (
			e : in std_logic_vector (3 downto 0) ;
			s : out std_logic_vector (15 downto 0)
		) ;
	end component ;
	component registres
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
		) ;
	end component ;
	component rams_asyn_read512x32
		port (
			clk  : in std_logic;
			we  : in std_logic;
			addr  : in std_logic_vector(8 downto 0);
			di  : in std_logic_vector(31 downto 0);
			do  : out std_logic_vector(31 downto 0)
		) ;
	end component ;
	component ual
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
		) ;
	end component ;
	component reg8
		port (
			rst : in std_logic ;
			clk : in std_logic ;
			cs : in std_logic ;
			d : in std_logic_vector (7 downto 0) ;
			q : out std_logic_vector (7 downto 0)
		) ;
	end component ;

	-- buffer signals declarations
	signal ir_int : std_logic_vector (31 downto 0) ;

	-- internal signals declarations
	signal oe : std_logic_vector (3 downto 0) ;
	signal abus : std_logic_vector (31 downto 0) ;
	signal cs : std_logic_vector (15 downto 0) ;
	signal bbus : std_logic_vector (31 downto 0) ;
	signal auxram1 : std_logic ;
	signal auxram2 : std_logic ;
	signal dbus_ram : std_logic_vector (31 downto 0) ;
	signal dbus_ual : std_logic_vector (31 downto 0) ;
	signal en : std_logic ;
	signal ez : std_logic ;
	signal evc : std_logic ;
	signal naux : std_logic ;
	signal zaux : std_logic ;
	signal vaux : std_logic ;
	signal caux : std_logic ;
	signal auxregs : std_logic ;
	signal dbus_switch : std_logic_vector (31 downto 0) ;
	signal auxregl : std_logic ;
	signal naux1 : std_logic ;
	signal zaux1 : std_logic ;
	signal vaux1 : std_logic ;
	signal caux1 : std_logic ;

begin

	-- buffer signals assignations
	ir(31 downto 0) <= ir_int(31 downto 0) ;

	-- concurrent statements
	auxram1 <= write and cs(0) ;
	auxram2 <= oe(2) and cs(0) ;
	auxregs <= oe(2) and cs(9) ;
	auxregl <= write and cs(11) ;
	naux1 <= naux and en ;
	zaux1 <= zaux and ez ;
	vaux1 <= vaux and evc ;
	caux1 <= caux and evc ;
	dbus_switch(31 downto 8) <= "000000000000000000000000" ;
	dbus(31 downto 0) <= dbus_ram(31 downto 0) when auxram2 = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	dbus(31 downto 0) <= dbus_ual(31 downto 0) when oe(1) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	dbus(31 downto 0) <= monitor(31 downto 0) when oe(3) = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
	dbus(31 downto 0) <= dbus_switch(31 downto 0) when auxregs = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;

	-- sequential statements
	process (clk, rst) begin
		if rst = '1' then
			n <= '0' ;
		elsif naux1 = '1' and clk'event and clk = '1' then
			n <= naux ;
		end if ;
	end process ;
	process (clk, rst) begin
		if rst = '1' then
			z <= '0' ;
		elsif zaux1 = '1' and clk'event and clk = '1' then
			z <= zaux ;
		end if ;
	end process ;
	process (clk, rst) begin
		if rst = '1' then
			v <= '0' ;
		elsif vaux1 = '1' and clk'event and clk = '1' then
			v <= vaux ;
		end if ;
	end process ;
	process (clk, rst) begin
		if rst = '1' then
			c <= '0' ;
		elsif caux1 = '1' and clk'event and clk = '1' then
			c <= caux ;
		end if ;
	end process ;

	-- components instanciations
	decoder2to4_0 : decoder2to4 port map (oe_num(1 downto 0), oe(3 downto 0)) ;
	decoder4to16_1 : decoder4to16 port map (abus(31 downto 28), cs(15 downto 0)) ;
	registres_2 : registres port map (rst, clk, areg(4 downto 0), breg(4 downto 0), dreg(4 downto 0), dbus(31 downto 0), abus(31 downto 0), bbus(31 downto 0), ir_int(31 downto 0), break) ;
	rams_asyn_read512x32_3 : rams_asyn_read512x32 port map (clk, auxram1, abus(8 downto 0), dbus(31 downto 0), dbus_ram(31 downto 0)) ;
	ual_4 : ual port map (abus(31 downto 0), bbus(31 downto 0), cmd_ual(5 downto 0), dbus_ual(31 downto 0), en, ez, evc, naux, zaux, vaux, caux) ;
	reg8_5 : reg8 port map (rst, swclk, '1', switch(7 downto 0), dbus_switch(7 downto 0)) ;
	reg8_6 : reg8 port map (rst, clk, auxregl, dbus(7 downto 0), leds(7 downto 0)) ;

end synthesis;
