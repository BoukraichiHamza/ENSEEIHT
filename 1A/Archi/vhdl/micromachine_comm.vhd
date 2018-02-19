library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity micromachine_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end micromachine_comm ;

architecture synthesis of micromachine_comm is

    -- submodules declarations
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
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal rst : std_logic ;
    signal clk : std_logic ;
    signal areg : std_logic_vector (4 downto 0) ;
    signal breg : std_logic_vector (4 downto 0) ;
    signal dreg : std_logic_vector (4 downto 0) ;
    signal cmd_ual : std_logic_vector (5 downto 0) ;
    signal oe_num : std_logic_vector (1 downto 0) ;
    signal write : std_logic ;
    signal monitor : std_logic_vector (31 downto 0) ;
    signal switch : std_logic_vector (7 downto 0) ;
    signal swclk : std_logic ;
    signal dbus : std_logic_vector (31 downto 0) ;
    signal n : std_logic ;
    signal z : std_logic ;
    signal v : std_logic ;
    signal c : std_logic ;
    signal ir : std_logic_vector (31 downto 0) ;
    signal break : std_logic ;
    signal leds : std_logic_vector (7 downto 0) ;

begin

    -- combinatorial statements
    rst <= pc2board(0) ;
    clk <= pc2board(1) ;
    areg(4 downto 0) <= pc2board(6 downto 2) ;
    breg(4 downto 0) <= pc2board(11 downto 7) ;
    dreg(4 downto 0) <= pc2board(16 downto 12) ;
    cmd_ual(5 downto 0) <= pc2board(22 downto 17) ;
    oe_num(1 downto 0) <= pc2board(24 downto 23) ;
    write <= pc2board(25) ;
    monitor(31 downto 0) <= pc2board(57 downto 26) ;
    switch(7 downto 0) <= pc2board(65 downto 58) ;
    swclk <= pc2board(66) ;
    board2pc(31 downto 0) <= dbus(31 downto 0) ;
    board2pc(32) <= n ;
    board2pc(33) <= z ;
    board2pc(34) <= v ;
    board2pc(35) <= c ;
    board2pc(67 downto 36) <= ir(31 downto 0) ;
    board2pc(68) <= break ;
    board2pc(76 downto 69) <= leds(7 downto 0) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    micromachine_0 : micromachine port map (rst, clk, areg(4 downto 0), breg(4 downto 0), dreg(4 downto 0), cmd_ual(5 downto 0), oe_num(1 downto 0), write, monitor(31 downto 0), switch(7 downto 0), swclk, dbus(31 downto 0), n, z, v, c, ir(31 downto 0), break, leds(7 downto 0)) ;


end synthesis;
