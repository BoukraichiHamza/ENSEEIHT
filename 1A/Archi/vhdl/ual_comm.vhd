library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ual_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end ual_comm ;

architecture synthesis of ual_comm is

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

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (31 downto 0) ;
    signal b : std_logic_vector (31 downto 0) ;
    signal cmd : std_logic_vector (5 downto 0) ;
    signal s : std_logic_vector (31 downto 0) ;
    signal en : std_logic ;
    signal ez : std_logic ;
    signal evc : std_logic ;
    signal n : std_logic ;
    signal z : std_logic ;
    signal v : std_logic ;
    signal c : std_logic ;

begin

    -- combinatorial statements
    a(31 downto 0) <= pc2board(31 downto 0) ;
    b(31 downto 0) <= pc2board(63 downto 32) ;
    cmd(5 downto 0) <= pc2board(69 downto 64) ;
    board2pc(31 downto 0) <= s(31 downto 0) ;
    board2pc(32) <= en ;
    board2pc(33) <= ez ;
    board2pc(34) <= evc ;
    board2pc(35) <= n ;
    board2pc(36) <= z ;
    board2pc(37) <= v ;
    board2pc(38) <= c ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    ual_0 : ual port map (a(31 downto 0), b(31 downto 0), cmd(5 downto 0), s(31 downto 0), en, ez, evc, n, z, v, c) ;


end synthesis;
