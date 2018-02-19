library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ucmp16_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end ucmp16_comm ;

architecture synthesis of ucmp16_comm is

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
	component ucmp16
		port (
			a : in std_logic_vector (15 downto 0) ;
			b : in std_logic_vector (15 downto 0) ;
			sup : out std_logic ;
			eq : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (15 downto 0) ;
    signal b : std_logic_vector (15 downto 0) ;
    signal sup : std_logic ;
    signal eq : std_logic ;

begin

    -- combinatorial statements
    a(15 downto 0) <= pc2board(15 downto 0) ;
    b(15 downto 0) <= pc2board(31 downto 16) ;
    board2pc(0) <= sup ;
    board2pc(1) <= eq ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    ucmp16_0 : ucmp16 port map (a(15 downto 0), b(15 downto 0), sup, eq) ;


end synthesis;
