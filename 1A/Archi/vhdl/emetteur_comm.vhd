library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity emetteur_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end emetteur_comm ;

architecture synthesis of emetteur_comm is

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
	component emetteur
		port (
			d4 : in std_logic ;
			d3 : in std_logic ;
			d2 : in std_logic ;
			d1 : in std_logic ;
			de4 : out std_logic ;
			de3 : out std_logic ;
			de2 : out std_logic ;
			c3 : out std_logic ;
			de1 : out std_logic ;
			c2 : out std_logic ;
			c1 : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal d4 : std_logic ;
    signal d3 : std_logic ;
    signal d2 : std_logic ;
    signal d1 : std_logic ;
    signal de4 : std_logic ;
    signal de3 : std_logic ;
    signal de2 : std_logic ;
    signal c3 : std_logic ;
    signal de1 : std_logic ;
    signal c2 : std_logic ;
    signal c1 : std_logic ;

begin

    -- combinatorial statements
    d4 <= pc2board(0) ;
    d3 <= pc2board(1) ;
    d2 <= pc2board(2) ;
    d1 <= pc2board(3) ;
    board2pc(0) <= de4 ;
    board2pc(1) <= de3 ;
    board2pc(2) <= de2 ;
    board2pc(3) <= c3 ;
    board2pc(4) <= de1 ;
    board2pc(5) <= c2 ;
    board2pc(6) <= c1 ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    emetteur_0 : emetteur port map (d4, d3, d2, d1, de4, de3, de2, c3, de1, c2, c1) ;


end synthesis;
