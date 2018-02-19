library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder16_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end adder16_comm ;

architecture synthesis of adder16_comm is

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
	component adder16
		port (
			a : in std_logic_vector (15 downto 0) ;
			b : in std_logic_vector (15 downto 0) ;
			cin : in std_logic ;
			s : out std_logic_vector (15 downto 0) ;
			cout : out std_logic
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal a : std_logic_vector (15 downto 0) ;
    signal b : std_logic_vector (15 downto 0) ;
    signal cin : std_logic ;
    signal s : std_logic_vector (15 downto 0) ;
    signal cout : std_logic ;

begin

    -- combinatorial statements
    a(15 downto 0) <= pc2board(15 downto 0) ;
    b(15 downto 0) <= pc2board(31 downto 16) ;
    cin <= pc2board(32) ;
    board2pc(15 downto 0) <= s(15 downto 0) ;
    board2pc(16) <= cout ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    adder16_0 : adder16 port map (a(15 downto 0), b(15 downto 0), cin, s(15 downto 0), cout) ;


end synthesis;
