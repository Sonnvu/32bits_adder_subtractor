library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addsub_32bit is
--  Port ( );
    GENERIC (
        WIDTH: positive := 32
    ) ;
    PORT ( K : in std_logic;
           A : in std_logic_vector(WIDTH-1 downto 0);
           B : in std_logic_vector(WIDTH-1 downto 0);
           S : out std_logic_vector(WIDTH-1 downto 0);
           cout : out std_logic );
end entity;

architecture rtl of addsub_32bit is

component fulladdsub
    PORT ( A : in std_logic;
           B : in std_logic;
           cin : in std_logic;
           s : out std_logic;
           cout : out std_logic ) ;
end component; 

signal m : std_logic_vector(0 to WIDTH-1);
signal C_in : std_logic_vector(0 to WIDTH-1);
signal C_out : std_logic_vector(0 to WIDTH-1);

begin
    -- Begin for-generate
    C_in(0) <= K;
    
    Carry_inout: for i in 0 to WIDTH-2 generate
        C_in(i+1) <= C_out(i) ;
    end generate ;
    
    G1: for i in 0 to WIDTH-1 generate
        m(i) <= K XOR B(i);
        AddSub: fulladdsub PORT MAP (A(i), m(i), C_in(i), S(i), C_out(i));
    end generate ;
    cout <= C_out(WIDTH-1) ;
end architecture;
