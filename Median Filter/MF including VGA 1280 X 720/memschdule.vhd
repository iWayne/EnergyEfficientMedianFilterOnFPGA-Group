----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:57:59 05/21/2014 
-- Design Name: 
-- Module Name:    memschdule - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memschdule is
port(
	showx0,showx1,showx2: out std_logic_vector(8 downto 0);
	showmed:out std_logic_vector(8 downto 0);
	showdout:out std_logic_vector(7 downto 0);
	show16:out std_logic_vector(3 downto 0);
	showaddram:out std_logic_vector(14 downto 0);
	showaddrom:out std_logic_vector(14 downto 0);
	
	----------------vga---------
	red_out:out std_logic_vector(2 downto 0);
	green_out:out std_logic_vector(2 downto 0);
	blue_out:out std_logic_vector(1 downto 0);
	hs_out:out std_logic;
	vs_out:out std_logic;
	------------------------------	
	
	clk,rst: in std_logic;
	fine: out std_logic
);
end memschdule;

architecture Behavioral of memschdule is
--------VGA--------------------
signal clk4: std_logic;
signal horz_scan: integer:=0;
signal vert_scan: integer:=0;
signal counter: std_logic_vector(2 downto 0);
----------Self----------------
signal finishi: std_logic;
----------Sorting-------------
signal y0,y1,y2: std_logic_vector(8 downto 0);
signal x0,x1,x2: std_logic_vector(8 downto 0);
signal median: std_logic_vector(8 downto 0);
----------RAM/ROM-------------
signal addramRd: std_logic_vector(14 downto 0);
signal addramWt: std_logic_vector(14 downto 0);
signal addrom1,addrom2: std_logic_vector(14 downto 0);
signal dinRAM: std_logic_vector(7 downto 0);
signal doutRAM: std_logic_vector(7 downto 0);
signal doutROM1,doutROM2: std_logic_vector(7 downto 0);
signal en0,en1: std_logic;
signal weaRAM: std_logic_vector(0 downto 0);

---------Counter---------------
signal counter16: std_logic_vector(3 downto 0);
signal addcount: std_logic_vector(14 downto 0);
---------Component------------
component sorting is
generic(n: integer :=3);
port(
		clk: in std_logic;
		rst: in std_logic;
		y0: in std_logic_vector (n-1 downto 0);
		y1: in std_logic_vector (n-1 downto 0);
		y2: in std_logic_vector (n-1 downto 0);
		med: out std_logic_vector(n-1 downto 0)
	);
end component;

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
-- clock divied by 1/4
	process(clk,rst)
		begin
			if(rst='1') then
				counter<="000";
				clk4<='0';
				--wearam<="0";
			elsif(clk'event and clk='1') then
				counter<=counter+'1';
				clk4<= counter(2);
				--show_clk<=conv_std_logic_vector(horz_scan,10);
			end if;
	end process;

----------RAM/ROM-------------
R0:ROM_I port map(clka=>clk,addra=>addrom1,douta=>doutROM1,clkb=>clk,addrb=>addrom2,doutb=>doutROM2);
R1:RAM_II port map(clka=>clk,ena=>en0,wea=>weaRAM,addra=>addramWt,dina=>dinRAM,clkb=>clk,
							enb=>en1,addrb=>addramRd,doutb=>doutRAM);

----------SORTING-------------
S0: sorting port map(clk=>clk,rst=>rst,y0=>y0(8 downto 6),y1=>y1(8 downto 6),y2=>y2(8 downto 6),med=>median(8 downto 6));
S1: sorting port map(clk=>clk,rst=>rst,y0=>y0(5 downto 3),y1=>y1(5 downto 3),y2=>y2(5 downto 3),med=>median(5 downto 3));
S2: sorting port map(clk=>clk,rst=>rst,y0=>y0(2 downto 0),y1=>y1(2 downto 0),y2=>y2(2 downto 0),med=>median(2 downto 0));

----------Counter-------------
count:process(clk,rst)
begin
	if(rst='1') then
		counter16<=(others=>'0');
	elsif(clk'event and clk='1') then
		counter16<=counter16+'1';
	end if;
end process;
----------SHEDULE-------------
process(clk,rst)
begin
	if(rst='1') then
		addrom1<=(others=>'0');
		addramWt<=(others=>'0');
		--addramRd<="100000000000000";
		dinram<=(others=>'0');
		wearam<="0";
		en0<='0';
		--en1<='0';
		x0<=(others=>'0');
		x1<=(others=>'0');
		x2<=(others=>'0');
		addcount<=(others=>'0');
		finishi<='0';
	elsif(clk'event and clk='1') then
		--wearam<="1";
		--en0<='1';
		--en1<='1';
		if(addcount<10#29600#) then
			if(counter16="0000") then
				x0<=doutrom1(7 downto 2)&'0'&doutrom1(1 downto 0);
				addrom1<=addcount+10#200#;
			elsif(counter16="0001") then
				x1<=doutrom1(7 downto 2)&'0'&doutrom1(1 downto 0);
				addrom1<=addcount+10#400#;
			elsif(counter16="0010") then
				x2<=doutrom1(7 downto 2)&'0'&doutrom1(1 downto 0);
				y2<=doutrom1(7 downto 2)&'0'&doutrom1(1 downto 0);
				y0<=x0;
				y1<=x1;
				addcount<=addcount+'1';
			elsif(counter16="1101") then
				en0<='1';
				wearam<="1";
				dinram<=median(8 downto 3)&median(1 downto 0);
			elsif(counter16="1110") then
				en0<='0';
				wearam<="0";
			elsif(counter16="1111") then
				addramWt<=addramWt+'1';
			end if;
		else
			finishi<='1';
		end if;
	end if;
end process;

-------------STORE---------------------

fine<=finishi;


------------Timing-----------------
	process(clk,rst)
		begin
			if(rst='1') then
				addrom2<=(others=>'0');
				addramRd<=(others=>'0');
				en1<='0';
			elsif(clk'event and clk='1') then
				en1<='1';
				if(horz_scan=1712) then
					horz_scan<=0;
						if(vert_scan=960) then
							vert_scan<=0;
						else
							vert_scan<=vert_scan+1;
						end if;
				else
					horz_scan<=horz_scan+1;
				end if;
				
				if(horz_scan>400 and horz_scan<601) then
					if(vert_scan>500 and vert_scan<651) then
						if(addrom2<10#30000#) then
							addrom2<=addrom2+'1';
						else
							addrom2<=(others=>'0');
						end if;
					end if;
				elsif(horz_scan>800 and horz_scan<1001) then
					if(vert_scan>500 and vert_scan<651) then
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
hs_out<='0' when horz_scan<136 else '1';
vs_out<='0' when vert_scan<3 else '1';

red_out<=doutROM2(7 downto 5)when vert_scan>500 and vert_scan<651 and horz_scan>=400 and horz_scan<601 else
			doutRAM (7 downto 5) when vert_scan>500 and vert_scan<651 and horz_scan>=800 and horz_scan<1001 else"000";
green_out<=doutROM2(4 downto 2)when vert_scan>500 and vert_scan<651 and horz_scan>=400 and horz_scan<601 else
			doutRAM (4 downto 2) when vert_scan>500 and vert_scan<651 and horz_scan>=800 and horz_scan<1001 else"000";
blue_out<=doutROM2(1 downto 0)when vert_scan>500 and vert_scan<651 and horz_scan>=400 and horz_scan<601 else
			doutRAM (1 downto 0) when vert_scan>500 and vert_scan<651 and horz_scan>=800 and horz_scan<1001 else"00";


-----test-----
showx0<=x0;
showx1<=x1;
showx2<=x2;
showmed<=median;
showdout<=doutrom1;
show16<=counter16;
showaddram<=addramWt;
showaddrom<=addrom1;
end Behavioral;

