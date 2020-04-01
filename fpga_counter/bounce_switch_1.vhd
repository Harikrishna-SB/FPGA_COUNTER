library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bounce_switch_1 is
 port( clk    : in std_logic; 
       switch : in std_logic_vector (3 downto 0) ;
	   out_switch : out std_logic_vector(3 downto 0)); 
	end entity bounce_switch_1;

architecture rtl of bounce_switch_1 is
  
  constant debounce_limit : integer:= 500000;   --for 10ms
 signal flag : std_logic_vector(3 downto 0):= (others =>'0') ;
 signal count :integer range 0 to debounce_limit :=0  ;

 
begin
     p_debounce : process (clk) is

      
    begin
      if (rising_edge(clk)) then
		  if(switch /= flag and count < debounce_limit) then
		  count <= count+1;
		  
		  elsif count =debounce_limit then
		  flag<=switch;
		  count <=0;
		  
		  else
		  count<=0;
		  end if;
		end if;
end process p_debounce;
out_switch <= flag;
end architecture rtl;

