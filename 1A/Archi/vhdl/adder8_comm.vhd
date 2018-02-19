library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder8_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end adder8_comm ;

architecture synthesis of adder8_comm is

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
	component adder8
		port (
			a : in std_logic_vector (7 downto 0) ;
			b : in std_logic_vector (7 downto 0) ;
			cin : in std_logic ;
			s : out std_logic_vector (7 downto 0) ;
			cout : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (7 downto 0) ;
    signal b : std_logic_vector (7 downto 0) ;
    signal cin : std_logic ;
    signal s : std_logic_vector (7 downto 0) ;
    signal cout : std_logic ;

begin

    -- combinatorial statements
    a(7 downto 0) <= pc2board(7 downto 0) ;
    b(7 downto 0) <= pc2board(15 downto 8) ;
    cin <= pc2board(16) ;
    board2pc(7 downto 0) <= s(7 downto 0) ;
    board2pc(8) <= cout ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    adder8_0 : adder8 port map (a(7 downto 0), b(7 downto 0), cin, s(7 downto 0), cout) ;


end synthesis;
