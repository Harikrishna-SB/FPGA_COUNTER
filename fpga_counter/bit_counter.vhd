library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit_counter is
port(
      clk    : in std_logic;
      switch : in std_logic_vector(3 downto 0);
 pov_switch0 : out std_logic;
 pov_switch1 : out std_logic;
 pov_switch2 : out std_logic;
 pov_switch3 : out std_logic;
     led_0 : out std_logic;
     led_1 : out std_logic;
     led_2 : out std_logic;
     led_3 : out std_logic;

		seg_a : out std_logic;
		seg_b : out std_logic;
		seg_c : out std_logic;
		seg_d : out std_logic;
		seg_e : out std_logic;
		seg_f : out std_logic;
		seg_g : out std_logic);
end entity bit_counter;		
		
		
architecture rtl of bit_counter is
   
   signal res : std_logic_vector(3 downto 0) :=(others =>'0');
   signal pov_count   : integer range 0 to 3 :=0; 
   signal r_count   : integer range 0 to 4096 :=0;
   signal r_auto_count   : integer range 0 to 4096 :=0;
   signal r_man_count   : integer range 0 to 4096 :=0;
   signal r_display : std_logic_vector(3 downto 0) :=(others =>'0');
    signal r_seg_a : std_logic  :='0';		
	signal r_seg_b : std_logic  :='0';		
	signal r_seg_c : std_logic  :='0';		
	signal r_seg_d : std_logic  :='0';		
	signal r_seg_e : std_logic  :='0';		
	signal r_seg_f : std_logic  :='0';		
	signal r_seg_g : std_logic  :='0';		
	signal r_state : std_logic_vector(3 downto 0) :=(others =>'0');
	signal pov_clk : std_logic  :='0';
	signal r_pov_clk : std_logic:='0';
	signal r_pov_switch0 : std_logic :='1';
	signal r_pov_switch1 : std_logic :='1';
	signal r_pov_switch2 : std_logic :='1';
	signal r_pov_switch3 : std_logic :='1';
	signal r_switch : std_logic_vector(3 downto 0) :=(others =>'0');
	signal r_count_clock : std_logic :='0';
	signal r_ones : std_logic_vector(3 downto 0) := (others =>'0');
	signal r_tens : std_logic_vector(3 downto 0) := (others =>'0');
	signal r_hundreds : std_logic_vector(3 downto 0) := (others =>'0');
	signal r_thousands : std_logic_vector(3 downto 0) := (others =>'0');
	signal counter :std_logic;
begin
   debounce_inst : entity work.bounce_switch_1
port map
    (
	    clk => clk,
		 switch=>switch,
		 out_switch=>r_state);
		 
   variable_clk_inst : entity work.clk_5kz
port map
    (    clk => clk,
	     var_clk=> r_pov_clk);

    count_clk_inst : entity work.counter_clk
    port map(
    	   clk=>clk,
           count_clk=>r_count_clock

    	);
		  
  pov: process(pov_clk)
     begin
	      if rising_edge(pov_clk) then   
           if (pov_Count = 3) then
           pov_Count <= 0;
        else
          pov_Count <= pov_Count + 1;
        end if; 
      end if;
	end process pov;	
	
	pov_switch : process (pov_clk) is
    begin
    if rising_edge(pov_clk) then
      case pov_count is
          when 0 =>
	         r_pov_switch0 <='0';
				r_pov_switch1 <='1';
				r_pov_switch2 <='1';
				r_pov_switch3 <='1';
             r_display <= r_ones;

			 when 1 =>
			   r_pov_switch1 <='0';
				r_pov_switch0 <='1';
				r_pov_switch2 <='1';
				r_pov_switch3 <='1';
             r_display <= r_tens;

			 when 2 =>
			   r_pov_switch2 <='0';
				r_pov_switch1 <='1';
				r_pov_switch0 <='1';
				r_pov_switch3 <='1';
             r_display <=  r_hundreds;

	         when 3 =>	 
				r_pov_switch3 <='0';
			   r_pov_switch1 <='1';
				r_pov_switch2 <='1';
				r_pov_switch0 <='1';	
             r_display <= r_thousands;

			end case;
		end if;
	end process pov_switch;	
				
		

   p_Switch_Count : process (Clk)
  begin
    if rising_edge(Clk) then
      r_switch <= r_state;
      pov_clk<=r_pov_clk;
      counter<= r_count_clock;
       
		 
		 if r_state(0)='0' and r_switch(0)='1' and res(2)='1' and res(3)='1' then
		 if (r_man_count = 4095) then
          r_man_count <= 0;
		   res(0)<=not res(0);
			
			else
          res(0)<=not res(0);
          r_man_count <= r_man_count + 1;
        end if;
			 end if;
			 
			 
			if r_state(1)='0' and r_switch(1)='1'  and res(2)='1' and res(3)='1' then
		   
			if (r_man_count = 0) then
          r_man_count <= 4095;
		   res(1)<=not res(1);
			
			else
          res(1)<=not res(1);
          r_man_count <= r_man_count - 1;
        end if;
			 end if;
			 
			 
			 if r_state(2)='0' and r_switch(2)='1' then
		   res(2)<=not res(2);
			 end if;
			 if r_state(3)='0' and r_switch(3)='1' then
		   res(3)<=not res(3);
			 end if;

			 if res(2)='0' or res(3)='0' then
			   r_count <= r_auto_Count;
			--	r_man_count <= r_auto_Count;
			   else
			   r_count <= r_man_count;
			--	r_auto_Count  <= r_man_count;
			  end if; 

    end if;
	 
	  end process p_Switch_Count;	
 

manual_count : process(counter)

 begin 

  	 if(rising_edge(counter)) then
        if res(2)='0' and res(3)='1' then
           if (r_auto_Count = 4095) then
         r_auto_Count <= 0;
	
			else
         r_auto_Count <= r_auto_Count + 1;
         end if;
       end if;


         if res(3)='0' and res(2)='1' then
             if (r_auto_Count = 0) then
          r_auto_Count <= 4095;

		else
          
         r_auto_Count <= r_auto_Count - 1;
        end if;
         end if;
    end if;
      
 end process manual_count; 
				
	bcd_inst : entity work.bintobcd_12bit
	 port map (
	 	    binIN =>  std_logic_vector(to_unsigned(r_Count, 12)),
	 	    ones => r_ones,
            tens => r_tens,
            hundreds=> r_hundreds,
            thousands=>r_thousands
	 	);		
				
				
		 SevenSeg1_Inst : entity work.Binary_2_7segment
    port map (
      Clk        => Clk,
      i_Binary_Num => r_display,
      o_Segment_A  => r_seg_a,
      o_Segment_B  => r_seg_b,
      o_Segment_C  => r_seg_c,
      o_Segment_D  => r_seg_d,
      o_Segment_E  => r_seg_e,
      o_Segment_F  => r_seg_f,
      o_Segment_G  => r_seg_g
      );
		
	  pov_switch0 <= r_pov_switch0;
      pov_switch1 <= r_pov_switch1;
      pov_switch2 <= r_pov_switch2;
      pov_switch3 <= r_pov_switch3;

      led_0 <= res(0);
      led_1 <= res(1);
      led_2 <= res(2);
      led_3 <= res(3);
  
		seg_a <= not r_seg_a;
		seg_b <= not r_seg_b;
	    seg_c <= not r_seg_c;
	    seg_d <= not r_seg_d;
		seg_e <= not r_seg_e;
	    seg_f <= not r_seg_f;
		seg_g <= not r_seg_g;
		
end architecture rtl;		
				