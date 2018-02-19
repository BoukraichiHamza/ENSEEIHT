library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift1_comm is
    port (
        mclk : in std_logic ;
        pdb : inout std_logic_vector (7 downto 0) ;
        astb : in std_logic ;
        dstb : in std_logic ;
        pwr : in std_logic ;
        pwait : out std_logic
) ;
end shift1_comm ;

architecture synthesis of shift1_comm is

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
	component shift1
		port (
			r : in std_logic ;
			en : in std_logic ;
			e : in std_logic_vector (31 downto 0) ;
			s : out std_logic_vector (31 downto 0)
		) ;
	end component ;

    -- internal signals declarations
    signal pc2board : std_logic_vector (127 downto 0) ;
    signal board2pc : std_logic_vector (127 downto 0) ;
    signal r : std_logic ;
    signal en : std_logic ;
    signal e : std_logic_vector (31 downto 0) ;
    signal s : std_logic_vector (31 downto 0) ;

begin

    -- combinatorial statements
    r <= pc2board(0) ;
    en <= pc2board(1) ;
    e(31 downto 0) <= pc2board(33 downto 2) ;
    board2pc(31 downto 0) <= s(31 downto 0) ;

    -- components instanciations
    commUSB_0 : commUSB port map (mclk, pdb(7 downto 0), astb, dstb, pwr, pwait, pc2board(127 downto 0), board2pc(127 downto 0)) ;
    shift1_0 : shift1 port map (r, en, e(31 downto 0), s(31 downto 0)) ;


end synthesis;
