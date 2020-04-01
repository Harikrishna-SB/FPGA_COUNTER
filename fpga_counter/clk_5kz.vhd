library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_5kz is
  generic (
    g_COUNT_HZ : integer := 10000);--5khz
  port (
    clk   : in  std_logic;
    var_clk : out std_logic
  
    );
end clk_5kz;

architecture RTL of clk_5kz is

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


 var_clk <= r_toggle_Hz;

  
end RTL;