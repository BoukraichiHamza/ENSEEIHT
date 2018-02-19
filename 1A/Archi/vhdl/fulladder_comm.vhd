library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fulladder_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end fulladder_comm ;

architecture synthesis of fulladder_comm is

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
	component fulladder
		port (
			a : in std_logic ;
			b : in std_logic ;
			cin : in std_logic ;
			s : out std_logic ;
			cout : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic ;
    signal b : std_logic ;
    signal cin : std_logic ;
    signal s : std_logic ;
    signal cout : std_logic ;

begin

    -- combinatorial statements
    a <= pc2board(0) ;
    b <= pc2board(1) ;
    cin <= pc2board(2) ;
    board2pc(0) <= s ;
    board2pc(1) <= cout ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    fulladder_0 : fulladder port map (a, b, cin, s, cout) ;


end synthesis;
