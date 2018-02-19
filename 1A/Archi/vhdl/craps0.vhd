library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity craps0 is
	port (
		mclk : in std_logic ;
		btn : in std_logic_vector (3 downto 0) ;
		sw : in std_logic_vector (7 downto 0) ;
		ld : out std_logic_vector (7 downto 0) ;
		pdb : inout std_logic_vector (7 downto 0) ;
		astb : in std_logic ;
		dstb : in std_logic ;
		pwr : in std_logic ;
		pwait : out std_logic
	);
end craps0;

architecture synthesis of craps0 is

	-- submodules declarations
	component clock28
		port (
			rst : in std_logic ;
			h : in std_logic ;
			s : out std_logic_vector (27 downto 0)
		) ;
	end component ;
    component commUSB
        port (
            mclk     : in std_logic;
            pdb      : inout std_logic_vector(7 downto 0);
            astb     : in std_logic;
            dstb     : in std_logic;
            pwr      : in std_logic;
            pwait    : out std_logic;
            pc2board : out std_logic_vector(127 downto 0);
            board2pc : in std_logic_vector(127 downto 0)
        ) ;
    end component ;
	component sequencer
		port (
			rst : in std_logic ;
			clk : in std_logic ;
			mon_req : in std_logic ;
			mon_cmd : in std_logic_vector (3 downto 0) ;
			monitor : in std_logic_vector (37 downto 0) ;
			break : in std_logic ;
			run : in std_logic ;
			ir : in std_logic_vector (31 downto 0) ;
			n : in std_logic ;
			z : in std_logic ;
			v : in std_logic ;
			c : in std_logic ;
			it : in std_logic ;
			write : out std_logic ;
			oe_num : out std_logic_vector (1 downto 0) ;
			areg : out std_logic_vector (4 downto 0) ;
			breg : out std_logic_vector (4 downto 0) ;
			dreg : out std_logic_vector (4 downto 0) ;
			cmd_ual : out std_logic_vector (5 downto 0) ;
			mon_ack : out std_logic
		) ;
	end component ;
	component micromachine
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
		) ;
	end component ;

	-- internal signals declarations
	signal rst : std_logic ;
	signal clock : std_logic_vector (27 downto 0) ;
	signal clk : std_logic ;
	signal swclk : std_logic ;
	signal xpc2board : std_logic_vector (127 downto 0) ;
	signal board2pc : std_logic_vector (127 downto 0) ;
	signal pc2board : std_logic_vector (127 downto 0) ;
	signal mon_cmd : std_logic_vector (3 downto 0) ;
	signal mon_req : std_logic ;
	signal run : std_logic ;
	signal monitor : std_logic_vector (37 downto 0) ;
	signal mon_ack : std_logic ;
	signal break : std_logic ;
	signal n : std_logic ;
	signal z : std_logic ;
	signal v : std_logic ;
	signal c : std_logic ;
	signal dbus : std_logic_vector (31 downto 0) ;
	signal ir : std_logic_vector (31 downto 0) ;
	signal write : std_logic ;
	signal oe_num : std_logic_vector (1 downto 0) ;
	signal areg : std_logic_vector (4 downto 0) ;
	signal breg : std_logic_vector (4 downto 0) ;
	signal dreg : std_logic_vector (4 downto 0) ;
	signal cmd_ual : std_logic_vector (5 downto 0) ;

begin

	-- concurrent statements
	rst <= btn(0) ;
	clk <= clock(4) ;
	swclk <= clock(19) ;
	mon_cmd(3 downto 0) <= pc2board(63 downto 60) ;
	mon_req <= pc2board(59) ;
	run <= pc2board(55) ;
	monitor(37 downto 0) <= pc2board(37 downto 0) ;
	board2pc(63) <= mon_ack ;
	board2pc(62) <= break ;
	board2pc(61) <= rst ;
	board2pc(60) <= n ;
	board2pc(59) <= z ;
	board2pc(58) <= v ;
	board2pc(57) <= c ;
	board2pc(31 downto 0) <= dbus(31 downto 0) ;

	-- sequential statements
	process (clk, rst) begin
		if rst = '1' then
			pc2board(127 downto 0) <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
		elsif clk'event and clk = '1' then
			pc2board(127 downto 0) <= xpc2board(127 downto 0) ;
		end if ;
	end process ;

	-- components instanciations
	clock28_0 : clock28 port map (rst, mclk, clock(27 downto 0)) ;
	commUSB_1 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, xpc2board(127 downto 0), board2pc(127 downto 0)) ;
	sequencer_2 : sequencer port map (rst, clk, mon_req, mon_cmd(3 downto 0), monitor(37 downto 0), break, run, ir(31 downto 0), n, z, v, c, '0', write, oe_num(1 downto 0), areg(4 downto 0), breg(4 downto 0), dreg(4 downto 0), cmd_ual(5 downto 0), mon_ack) ;
	micromachine_3 : micromachine port map (rst, clk, areg(4 downto 0), breg(4 downto 0), dreg(4 downto 0), cmd_ual(5 downto 0), oe_num(1 downto 0), write, monitor(31 downto 0), sw(7 downto 0), swclk, dbus(31 downto 0), n, z, v, c, ir(31 downto 0), break, ld(7 downto 0)) ;

end synthesis;
