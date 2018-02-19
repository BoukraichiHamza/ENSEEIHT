library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity barrelshifter32_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end barrelshifter32_comm ;

architecture synthesis of barrelshifter32_comm is

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
	component barrelshifter32
		port (
			r : in std_logic ;
			nb : in std_logic_vector (4 downto 0) ;
			e : in std_logic_vector (31 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal r : std_logic ;
    signal nb : std_logic_vector (4 downto 0) ;
    signal e : std_logic_vector (31 downto 0) ;
    signal s : std_logic_vector (31 downto 0) ;

begin

    -- combinatorial statements
    r <= pc2board(0) ;
    nb(4 downto 0) <= pc2board(5 downto 1) ;
    e(31 downto 0) <= pc2board(37 downto 6) ;
    board2pc(31 downto 0) <= s(31 downto 0) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    barrelshifter32_0 : barrelshifter32 port map (r, nb(4 downto 0), e(31 downto 0), s(31 downto 0)) ;


end synthesis;
