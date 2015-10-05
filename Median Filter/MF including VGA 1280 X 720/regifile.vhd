----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:27:19 05/09/2014 
-- Design Name: 
-- Module Name:    regifile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity regifile is
generic( n: integer :=3);
port(
     I     :in std_logic_vector(n-1 downto 0);
	  clk   :in std_logic;
	  rst   :in std_logic;
	  load  :in std_logic;
	  Q     :out std_logic_vector(n-1 downto 0)
	  );
end regifile;

architecture Behavioral of regifile is
signal Q_tmp : std_logic_vector(n-1 downto 0);
begin
  process(clk,rst,load)
  begin
    if(rst='1')then
	   Q_tmp<=(others=>'0');
	 elsif (rising_edge(clk) and load='1')then
	   Q_tmp<=I;
	 end if;
  end process;
  Q<=Q_tmp;
end Behavioral;

