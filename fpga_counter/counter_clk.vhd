library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_clk is
  generic (
    g_COUNT_HZ : integer := 2000000);--0.4s
  port (
    clk   : in  std_logic;
    count_clk : out std_logic
  
    );
end counter_clk;

architecture RTL of counter_clk is

  signal r_Count_Hz : integer range 0 to g_COUNT_HZ :=0;

  signal r_Toggle_Hz : std_logic := '0';


begin

  
  
  
  p_Hz : process (clk) is
  begin
    if rising_edge(clk) then
      if r_Count_Hz = g_COUNT_HZ then
        r_Toggle_Hz <= not r_Toggle_Hz;
        r_Count_Hz  <= 0;
      else
        r_Count_Hz <= r_Count_Hz + 1;
      end if;
    end if;
  end process p_Hz;


 count_clk <= r_toggle_Hz;

  
end RTL;