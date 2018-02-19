library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testaffmux_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic;
        an : out std_logic_vector (3 downto 0) ;

        ssg : out std_logic_vector (6 downto 0)

) ;
end testaffmux_comm ;

architecture synthesis of testaffmux_comm is

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
	component testaffmux
		port (
			rst : in std_logic ;
			mclk : in std_logic ;
			data : in std_logic_vector (15 downto 0) ;
			an : out std_logic_vector (3 downto 0) ;
			ssg : out std_logic_vector (6 downto 0)
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal rst : std_logic ;
    signal data : std_logic_vector (15 downto 0) ;

begin

    -- combinatorial statements
    rst <= pc2board(0) ;
    data(15 downto 0) <= pc2board(16 downto 1) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    testaffmux_0 : testaffmux port map (rst, mclk, data(15 downto 0), an(3 downto 0), ssg(6 downto 0)) ;


end synthesis;
