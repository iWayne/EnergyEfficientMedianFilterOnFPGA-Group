LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY sorting_tb IS
END sorting_tb;
 
ARCHITECTURE behavior OF sorting_tb IS 
 
    COMPONENT sorting
    generic(n: integer :=3);
	 PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         y0 : IN  std_logic_vector(2 downto 0);
         y1 : IN  std_logic_vector(2 downto 0);
         y2 : IN  std_logic_vector(2 downto 0);
         med : OUT  std_logic_vector(2 downto 0);
			
			
			 
			
			
			------test----
			cx2, cx5, cx8: out std_logic_vector(n-1 downto 0);
			cx1, cx4, cx7: out std_logic_vector(n-1 downto 0);
		   cx0, cx3, cx6: out std_logic_vector(n-1 downto 0);
		   cp1, cp2, cp3, cp4, cp5, cp6: out std_logic_vector(n-1 downto 0);
			cp7, cp8, cp11, cp13, cp16, cp17, cp20: out std_logic_vector(n-1 downto 0);
			cp9, cp12, cp14, cp18, cp10, cp15, cp19: out std_logic_vector(n-1 downto 0);
		   cp21, cp23, cp25, cp22, cp24: out std_logic_vector(n-1 downto 0)
        );  
    END COMPONENT;
   
	--test
	signal cx2, cx5, cx8: std_logic_vector(2 downto 0);
	signal cx1, cx4, cx7: std_logic_vector(2 downto 0);
	signal cx0, cx3, cx6: std_logic_vector(2 downto 0);
	
	signal cp1, cp2, cp3: std_logic_vector(2 downto 0);
   signal cp4, cp5, cp6: std_logic_vector(2 downto 0);	
	signal cp7, cp8, cp11, cp13, cp16, cp17, cp20: std_logic_vector(2 downto 0);
	
	signal cp9, cp12, cp14, cp18, cp10, cp15, cp19:  std_logic_vector(2 downto 0);
	signal cp21, cp23, cp25, cp22, cp24:  std_logic_vector(2 downto 0);
	

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal y0 : std_logic_vector(2 downto 0) := (others => '0');
   signal y1 : std_logic_vector(2 downto 0) := (others => '0');
   signal y2 : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal med : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sorting PORT MAP (
          clk => clk,
          rst => rst,
          y0 => y0,
          y1 => y1,
          y2 => y2,
          med => med,
			 
			 ----test
			 cx2=> cx2, 
			 cx5=> cx5,
			 cx8=> cx8,
			 cx1=>cx1, cx4=>cx4, cx7=>cx7,
			 cx0=>cx0, cx3=>cx3, cx6=>cx6,

			 cp1=> cp1, 
			 cp2=> cp2,
			 cp3=> cp3,
			 cp4=> cp4, 
			 cp5=> cp5,
			 cp6=> cp6,
			 
			 
			 cp7=> cp7,
			 cp8=> cp8,
			 cp11=> cp11,
			 cp13=> cp13,
			 cp16=> cp16,
			 cp17=> cp17,
			 cp20=> cp20,
			 
			 cp9=>cp9,
			 cp12=>cp12,
			 cp14=>cp14,
			 cp18=>cp18,
			 cp10=>cp10,
			 cp15=>cp15,
			 cp19=>cp19,
			 cp21=>cp21,
			 cp23=>cp23,
			 cp25=>cp25,
			 cp22=>cp22,
			 cp24=>cp24
			 
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		rst<='0';
      -- insert stimulus here 
		y0<="000";
		y1<="001";
		y2<="010";
		wait for 10 ns;
		y0<="011";
		y1<="100";
		y2<="101";
		wait for 10 ns;
		y0<="110";
		y1<="111";
		y2<="000";
		wait for 10 ns;
		y0<="001";
		y1<="010";
		y2<="011";
		wait for 10 ns;
		y0<="100";
		y1<="101";
		y2<="110";
		wait for 10 ns;
		y0<="111";
		y1<="000";
		y2<="001";
		wait for 10 ns;
		y0<="010";
		y1<="011";
		y2<="100";
		wait for 10 ns;
		y0<="101";
		y1<="110";
		y2<="111";
		wait for 10 ns;
		y0<="000";
		y1<="001";
		y2<="010";
		wait for 10 ns;
		y0<="011";
		y1<="100";
		y2<="101";
		wait for 10 ns;
		y0<="110";
		y1<="111";
		y2<="000";
		wait for 10 ns;
		y0<="001";
		y1<="010";
		y2<="011";
		wait for 10 ns;
		y0<="100";
		y1<="101";
		y2<="110";
		wait for 10 ns;
		y0<="111";
		y1<="000";
		y2<="001";
		wait for 10 ns;
		y0<="010";
		y1<="011";
		y2<="100";
		wait for 10 ns;
		y0<="101";
		y1<="110";
		y2<="111";
		wait for 10 ns;

		wait;
   end process;

END;
