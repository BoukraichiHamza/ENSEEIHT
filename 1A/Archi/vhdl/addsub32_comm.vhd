library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addsub32_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end addsub32_comm ;

architecture synthesis of addsub32_comm is

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

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (31 downto 0) ;
    signal b : std_logic_vector (31 downto 0) ;
    signal sub : std_logic ;
    signal s : std_logic_vector (31 downto 0) ;
    signal v : std_logic ;
    signal c : std_logic ;

begin

    -- combinatorial statements
    a(31 downto 0) <= pc2board(31 downto 0) ;
    b(31 downto 0) <= pc2board(63 downto 32) ;
    sub <= pc2board(64) ;
    board2pc(31 downto 0) <= s(31 downto 0) ;
    board2pc(32) <= v ;
    board2pc(33) <= c ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    addsub32_0 : addsub32 port map (a(31 downto 0), b(31 downto 0), sub, s(31 downto 0), v, c) ;


end synthesis;
