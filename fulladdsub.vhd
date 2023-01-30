library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fulladdsub is
--  Port ( );
    PORT ( A : in std_logic;
           B : in std_logic;
           cin : in std_logic;
           S : out std_logic;
           cout : out std_logic ) ;
end fulladdsub;

architecture Behavioral of fulladdsub is
begin
    S <= A XOR B XOR cin;
    cout <= (A AND B) OR (cin AND A) OR (cin AND B) ;
end Behavioral;
