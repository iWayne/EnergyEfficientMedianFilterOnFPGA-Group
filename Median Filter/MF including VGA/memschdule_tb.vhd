--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:05:49 05/21/2014
-- Design Name:   
-- Module Name:   C:/Users/Shawn/Documents/Visual Studio 2012/Projects/memory_modified_vga/memory_modified/memschdule_tb.vhd
-- Project Name:  memory
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memschdule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY memschdule_tb IS
END memschdule_tb;
 
ARCHITECTURE behavior OF memschdule_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memschdule
    PORT(
         showx0 : OUT  std_logic_vector(8 downto 0);
         showx1 : OUT  std_logic_vector(8 downto 0);
         showx2 : OUT  std_logic_vector(8 downto 0);
         showmed : OUT  std_logic_vector(8 downto 0);
         showdout : OUT  std_logic_vector(7 downto 0);
         show16 : OUT  std_logic_vector(3 downto 0);
         showaddram : OUT  std_logic_vector(14 downto 0);
         showaddrom : OUT  std_logic_vector(14 downto 0);
         red_out : OUT  std_logic_vector(2 downto 0);
         green_out : OUT  std_logic_vector(2 downto 0);
         blue_out : OUT  std_logic_vector(1 downto 0);
         hs_out : OUT  std_logic;
         vs_out : OUT  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         fine : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal showx0 : std_logic_vector(8 downto 0);
   signal showx1 : std_logic_vector(8 downto 0);
   signal showx2 : std_logic_vector(8 downto 0);
   signal showmed : std_logic_vector(8 downto 0);
   signal showdout : std_logic_vector(7 downto 0);
   signal show16 : std_logic_vector(3 downto 0);
   signal showaddram : std_logic_vector(14 downto 0);
   signal showaddrom : std_logic_vector(14 downto 0);
   signal red_out : std_logic_vector(2 downto 0);
   signal green_out : std_logic_vector(2 downto 0);
   signal blue_out : std_logic_vector(1 downto 0);
   signal hs_out : std_logic;
   signal vs_out : std_logic;
   signal fine : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memschdule PORT MAP (
          showx0 => showx0,
          showx1 => showx1,
          showx2 => showx2,
          showmed => showmed,
          showdout => showdout,
          show16 => show16,
          showaddram => showaddram,
          showaddrom => showaddrom,
          red_out => red_out,
          green_out => green_out,
          blue_out => blue_out,
          hs_out => hs_out,
          vs_out => vs_out,
          clk => clk,
          rst => rst,
          fine => fine
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst<='1';
		wait for 30 ns;
		rst<='0';
      wait;
   end process;

END;
