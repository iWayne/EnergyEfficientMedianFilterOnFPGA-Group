----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:37:19 05/09/2014 
-- Design Name: 
-- Module Name:    PE - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity PE is
generic(n: integer:= 3);
port(
    clk  : in std_logic;
	 rst  : in std_logic;
	 load : in std_logic;
	 A    : in std_logic_vector(n-1 downto 0);
	 B    : in std_logic_vector(n-1 downto 0);
	 H    : out std_logic_vector(n-1 downto 0);
	 L    : out std_logic_vector(n-1 downto 0)
	 );
end PE;

architecture Behavioral of PE is
component regifile 
generic(n: integer :=3);
port(
     I     :in std_logic_vector(n-1 downto 0);
	  clk   :in std_logic;
	  rst   :in std_logic;
	  load  :in std_logic;
	  Q     :out std_logic_vector(n-1 downto 0)
	  );
end component;

signal inter1 : std_logic;
signal mu1,mu2: std_logic_vector(n-1 downto 0);

begin
  DUT1: regifile port map(
                          I=>mu1,clk=>clk,rst=>rst,load=>load,Q=>H
								  );
  DUT2: regifile port map(
                          I=>mu2,clk=>clk,rst=>rst,load=>load,Q=>L
								  );							
  
  inter1<='1' when A<B else
          '0';
  
  with inter1 select
    mu1<= A when '0',
	       B when others;
			 
  with inter1 select
    mu2<= B when '0',
	       A when others;
			  
end Behavioral;

