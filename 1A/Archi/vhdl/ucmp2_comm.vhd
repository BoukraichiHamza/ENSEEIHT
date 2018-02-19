library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ucmp2_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end ucmp2_comm ;

architecture synthesis of ucmp2_comm is

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
	component ucmp2
		port (
			a : in std_logic_vector (1 downto 0) ;
			b : in std_logic_vector (1 downto 0) ;
			sup : out std_logic ;
			eq : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (1 downto 0) ;
    signal b : std_logic_vector (1 downto 0) ;
    signal sup : std_logic ;
    signal eq : std_logic ;

begin

    -- combinatorial statements
    a(1 downto 0) <= pc2board(1 downto 0) ;
    b(1 downto 0) <= pc2board(3 downto 2) ;
    board2pc(0) <= sup ;
    board2pc(1) <= eq ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    ucmp2_0 : ucmp2 port map (a(1 downto 0), b(1 downto 0), sup, eq) ;


end synthesis;
