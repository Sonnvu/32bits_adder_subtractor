library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab_1_tb is  
end lab_1_tb;

architecture TB of lab_1_tb is

  signal A, B, S     : std_logic_vector(31 downto 0);
  signal K, cout  : std_logic;
  
  component addsub_32bit is
    GENERIC (
        WIDTH : positive := 32
        ) ;
    PORT (
           K : in std_logic;
           A : in std_logic_vector(WIDTH-1 downto 0);
           B : in std_logic_vector(WIDTH-1 downto 0);
           S : out std_logic_vector(WIDTH-1 downto 0);
           cout : out std_logic ) ;
  end component;
  
begin  -- TB
  UUT : addsub_32bit
    port map (
      K    => K,
      A    => A,
      B    => B,
      S    => S,
      cout => cout
      );

  process
--    variable temp : std_logic_vector(2 downto 0);
--    variable input1     : std_logic_vector := x"17" ;
--    variable input2     : std_logic_vector := x"23" ;
    variable add     : std_logic := '0' ;
    variable sub     : std_logic := '1' ;
  begin
    report "----------SIMULATION START----------" ;
-- CORNER CASES
    -- CORNER CASE 1: A + B, S < +2^32-1 (carry out = 0)
    A <= x"00000017" ;
    B <= x"00000023" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"0000003a") report "Corner case 1 failed";
    assert(S < x"FFFFFFFF") report "Corner case 1 failed";
    assert(cout = '0') report "Corner case 1 failed";
    
    -- CORNER CASE 2: A + B, S > +2^32-1 (carry out = 1)
    A <= x"FFFFFFFF" ;
    B <= x"00000001" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"00000000") report "Corner case 2 failed";
    assert(cout = '1') report "Corner case 2 failed";
    
    -- CORNER CASE 3: A - B, S > 0 (carry out = 1)
    A <= x"ffffffff" ;
    B <= x"eeeeeeee" ;
    K <= sub ;
    wait for 10ns;
    assert(S > x"00000000") report "Corner case 3 failed";
    assert(cout = '1') report "Corner case 3 failed";

    -- CORNER CASE 4: A - B, S = 0 (carry out = 1)
    A <= x"80000000" ;
    B <= x"80000000" ;
    K <= sub ;
    wait for 10ns;
    assert(S = x"00000000") report "Corner case 4 failed";
    assert(cout = '1') report "Corner case 4 failed";

    -- CORNER CASE 5: A - B, S < 0 (carry out = 0)
    A <= x"eeeeeeee" ;
    B <= x"ffffffff" ;
    K <= sub ;
    wait for 10ns;
    assert(S < x"eeeeffff") report "Corner case 5 failed";
    assert(cout = '0') report "Corner case 5 failed";
    
-- RANDOM TESTING:
    A <= x"00000001" ;
    B <= x"00000001" ;
    K <= sub ;
    wait for 10ns;
    assert(S = x"00000000") report "Random test 1 failed";
    
    A <= x"00000002" ;
    B <= x"00000003" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"00000005") report "Random test 2 failed";
    
    A <= x"00000005" ;
    B <= x"00000006" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"0000000B") report "Random test 3 failed";
    assert(cout = '0') report "Random test 3 failed";
    
    A <= x"12345678" ;
    B <= x"00001234" ;
    K <= sub ;
    wait for 10ns;
    assert(S = x"12344444") report "Random test 4 failed";
    
    A <= x"00015555" ;
    B <= x"000012FF" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"00016854") report "Random test 5 failed";
    
    A <= x"FFFFFFFF" ;
    B <= x"00000003" ;
    K <= add ;
    wait for 10ns;
    assert(S = x"00000002") report "Random test 3 failed";
    assert(cout = '1') report "Random test 3 failed";

    report "----------SIMULATION FINISHED!----------" ;
    wait;
  end process;
end TB;