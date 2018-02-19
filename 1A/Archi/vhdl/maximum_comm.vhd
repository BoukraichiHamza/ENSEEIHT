library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity maximum_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end maximum_comm ;

architecture synthesis of maximum_comm is

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
	component maximum
		port (
			rst : in std_logic ;
			h : in std_logic ;
			val : in std_logic_vector (3 downto 0) ;
			max : out std_logic_vector (3 downto 0)
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal rst : std_logic ;
    signal h : std_logic ;
    signal val : std_logic_vector (3 downto 0) ;
    signal max : std_logic_vector (3 downto 0) ;

begin

    -- combinatorial statements
    rst <= pc2board(0) ;
    h <= pc2board(1) ;
    val(3 downto 0) <= pc2board(5 downto 2) ;
    board2pc(3 downto 0) <= max(3 downto 0) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    maximum_0 : maximum port map (rst, h, val(3 downto 0), max(3 downto 0)) ;


end synthesis;
