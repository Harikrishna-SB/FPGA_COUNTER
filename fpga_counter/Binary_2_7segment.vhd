library ieee;
use ieee.std_logic_1164.all;
 
entity Binary_2_7Segment is
  port (
    Clk        : in  std_logic;
    i_Binary_Num : in  std_logic_vector(3 downto 0);
    o_Segment_A  : out std_logic;
    o_Segment_B  : out std_logic;
    o_Segment_C  : out std_logic;
    o_Segment_D  : out std_logic;
    o_Segment_E  : out std_logic;
    o_Segment_F  : out std_logic;
    o_Segment_G  : out std_logic
	-- o_Segment_dot: out std_logic); 
    );
end entity Binary_2_7Segment;
 
architecture RTL of Binary_2_7Segment is
 
  signal r_Hex_Encoding : std_logic_vector(7 downto 0) := (others => '0');
   
begin
 
  process (Clk) is
  begin
    if rising_edge(Clk) then
      case i_Binary_Num is
        when "0000" =>
          r_Hex_Encoding <= X"3F";
        when "0001" =>
          r_Hex_Encoding <= X"06";
        when "0010" =>
          r_Hex_Encoding <= X"5B";
        when "0011" =>
          r_Hex_Encoding <= X"4F";
        when "0100" =>
          r_Hex_Encoding <= X"66";          
        when "0101" =>
          r_Hex_Encoding <= X"6D";
        when "0110" =>
          r_Hex_Encoding <= X"7D";
        when "0111" =>
          r_Hex_Encoding <= X"07";
        when "1000" =>
          r_Hex_Encoding <= X"7F";
        when "1001" =>
          r_Hex_Encoding <= X"6F";
        when "1010" =>
          r_Hex_Encoding <= X"77";
        when "1011" =>
          r_Hex_Encoding <= X"7C";
        when "1100" =>
          r_Hex_Encoding <= X"39";
        when "1101" =>
          r_Hex_Encoding <= X"5E";
        when "1110" =>
          r_Hex_Encoding <= X"79";
        when "1111" =>
          r_Hex_Encoding <= X"71";
      end case;
    end if;
  end process;
 
  -- r_Hex_Encoding(7) is unused
  o_Segment_A <= r_Hex_Encoding(0);
  o_Segment_B <= r_Hex_Encoding(1);
  o_Segment_C <= r_Hex_Encoding(2);
  o_Segment_D <= r_Hex_Encoding(3);
  o_Segment_E <= r_Hex_Encoding(4);
  o_Segment_F <= r_Hex_Encoding(5);
  o_Segment_G <= r_Hex_Encoding(6);
 
end architecture RTL;