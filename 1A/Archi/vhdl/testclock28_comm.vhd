library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testclock28_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic;
        ld : out std_logic_vector (7 downto 0)

) ;
end testclock28_comm ;

architecture synthesis of testclock28_comm is

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
	component testclock28
		port (
			rst : in std_logic ;
			mclk : in std_logic ;
			s : out std_logic_vector (27 downto 0) ;
			ld : out std_logic_vector (7 downto 0)
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal rst : std_logic ;
    signal s : std_logic_vector (27 downto 0) ;

begin

    -- combinatorial statements
    rst <= pc2board(0) ;
    board2pc(27 downto 0) <= s(27 downto 0) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    testclock28_0 : testclock28 port map (rst, mclk, s(27 downto 0), ld(7 downto 0)) ;


end synthesis;
