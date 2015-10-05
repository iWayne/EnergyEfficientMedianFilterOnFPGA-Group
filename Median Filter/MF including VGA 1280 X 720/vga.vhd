----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:17:21 05/21/2014 
-- Design Name: 
-- Module Name:    vga - Behavioral 
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
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga is
port(
		fine:in std_logic;
		rst:in std_logic;
		mclk:in std_logic;
		red_out:out std_logic_vector(2 downto 0);
		green_out:out std_logic_vector(2 downto 0);
		blue_out:out std_logic_vector(1 downto 0);
		hs_out:out std_logic;
		vs_out:out std_logic);
end vga;

architecture Behavioral of vga is
--signal clk2: std_logic;
signal clk4: std_logic;
signal horz_scan: integer:=0;
signal vert_scan: integer:=0;
signal counter: std_logic_vector(2 downto 0);
----------RAM/ROM-------------
signal addramRd: std_logic_vector(14 downto 0);
signal addramWt: std_logic_vector(14 downto 0);
signal addrom1,addrom2: std_logic_vector(14 downto 0);
signal dinRAM: std_logic_vector(7 downto 0);
signal doutRAM: std_logic_vector(7 downto 0);
signal doutROM1,doutROM2: std_logic_vector(7 downto 0);
signal en0,en1: std_logic;
signal weaRAM: std_logic_vector(0 downto 0);

---------RAM/ROM Component------
COMPONENT ROM_I
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

COMPONENT RAM_II
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

begin
------------Port map------------
R0:ROM_I port map(clka=>mclk,addra=>addrom1,douta=>doutROM1,clkb=>mclk,addrb=>addrom2,doutb=>doutROM2);
R1:RAM_II port map(clka=>mclk,ena=>en0,wea=>weaRAM,addra=>addramWt,dina=>dinRAM,clkb=>mclk,
							enb=>en1,addrb=>addramRd,doutb=>doutRAM);

-- clock divied by 1/4
	process(mclk,rst)
		begin
			if(rst='1') then
				counter<="000";
				clk4<='0';
				wearam<="0";
			elsif(mclk'event and mclk='1') then
				counter<=counter+'1';
				clk4<= counter(2);
				--show_clk<=conv_std_logic_vector(horz_scan,10);
			end if;
	end process;

------------Timing-----------------
	process(clk4,rst)
		begin
			if(rst='1') then
				addrom2<=(others=>'0');
				addramRd<=(others=>'0');
			elsif(clk4'event and clk4='1') then
				if(horz_scan=800) then
					horz_scan<=0;
						if(vert_scan=525) then
							vert_scan<=0;
						else
							vert_scan<=vert_scan+1;
						end if;
				else
					horz_scan<=horz_scan+1;
				end if;
				
				if(horz_scan>150 and horz_scan<351) then
					if(vert_scan>200 and vert_scan<351) then
						if(addrom2<10#30000#) then
							addrom2<=addrom2+'1';
						else
							addrom2<=(others=>'0');
						end if;
					end if;
				elsif(horz_scan>400 and horz_scan<601) then
					if(vert_scan>200 and vert_scan<351) then
						if(addramRd<10#30000#) then
							addramRd<=addramRd+'1';
						else
							addramRd<=(others=>'0');
						end if;
					end if;
				end if;
			end if;
	end process;

-----------Port-------
hs_out<='0' when horz_scan<96 else '1';
vs_out<='0' when vert_scan<2 else '1';

red_out<=doutROM2(7 downto 5)when vert_scan>200 and vert_scan<351 and horz_scan>=150 and horz_scan<351 else
			doutRAM (7 downto 5) when vert_scan>200 and vert_scan<351 and horz_scan>=400 and horz_scan<601 else"000";
green_out<=doutROM2(4 downto 2)when vert_scan>200 and vert_scan<351 and horz_scan>=150 and horz_scan<351 else
			doutRAM (4 downto 2) when vert_scan>200 and vert_scan<351 and horz_scan>=400 and horz_scan<601 else"000";
blue_out<=doutROM2(1 downto 0)when vert_scan>200 and vert_scan<351 and horz_scan>=150 and horz_scan<351 else
			doutRAM (1 downto 0) when vert_scan>200 and vert_scan<351 and horz_scan>=400 and horz_scan<601 else"00";



end Behavioral;

