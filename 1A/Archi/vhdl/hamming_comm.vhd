library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hamming_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end hamming_comm ;

architecture synthesis of hamming_comm is

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
	component hamming
		port (
			d4 : in std_logic ;
			d3 : in std_logic ;
			d2 : in std_logic ;
			d1 : in std_logic ;
			er : in std_logic_vector (6 downto 0) ;
			err : out std_logic ;
			dr4 : out std_logic ;
			dr3 : out std_logic ;
			dr2 : out std_logic ;
			dr1 : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal d4 : std_logic ;
    signal d3 : std_logic ;
    signal d2 : std_logic ;
    signal d1 : std_logic ;
    signal er : std_logic_vector (6 downto 0) ;
    signal err : std_logic ;
    signal dr4 : std_logic ;
    signal dr3 : std_logic ;
    signal dr2 : std_logic ;
    signal dr1 : std_logic ;

begin

    -- combinatorial statements
    d4 <= pc2board(0) ;
    d3 <= pc2board(1) ;
    d2 <= pc2board(2) ;
    d1 <= pc2board(3) ;
    er(6 downto 0) <= pc2board(10 downto 4) ;
    board2pc(0) <= err ;
    board2pc(1) <= dr4 ;
    board2pc(2) <= dr3 ;
    board2pc(3) <= dr2 ;
    board2pc(4) <= dr1 ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    hamming_0 : hamming port map (d4, d3, d2, d1, er(6 downto 0), err, dr4, dr3, dr2, dr1) ;


end synthesis;
