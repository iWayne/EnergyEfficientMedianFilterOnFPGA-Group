library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity main is
	generic(n: integer :=8);
	port(
		clk: std_logic;
		rst: std_logic;
		data_out: out std_logic_vector(n-1 downto 0)
	);
end main;

architecture Behavioral of main is

signal data_counter: std_logic_vector(1 downto 0);

-----------------call rom-------------------------
COMPONENT rom_initial is
  PORT (
    clka : IN STD_LOGIC;
    rsta : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    regcea : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
signal en_rom: std_logic;
signal addr_rom: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal regce_rom: std_logic;
signal dout_rom: STD_LOGIC_VECTOR(7 DOWNTO 0);
--------------------------------------------------

----------------call ram--------------------------
COMPONENT ram_operation is
  PORT (
    clka : IN STD_LOGIC;
    rsta : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    regcea : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
signal en_ram: std_logic;
signal din_ram: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal dout_ram:STD_LOGIC_VECTOR(7 DOWNTO 0);
signal we_ram: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal regce_ram: STD_LOGIC;
signal addr_ram: STD_LOGIC_VECTOR(15 DOWNTO 0);
--------------------------------------------------

----------------call sorting----------------------
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
signal data0, data1, data2: std_logic_vector (n-1 downto 0);
signal y0_r, y1_r, y2_r, med_r: std_logic_vector (3 downto 0);
signal y0_g, y1_g, y2_g, med_g: std_logic_vector (3 downto 0);
signal y0_b, y1_b, y2_b, med_b: std_logic_vector (3 downto 0);
--------------------------------------------------

begin
sort_r: sorting port map(clk=> clk, rst=> rst, y0=>y0_r, y1=>y1_r, y2=>y2_r, med=>med_r);
sort_g: sorting port map(clk=> clk, rst=> rst, y0=>y0_g, y1=>y1_g, y2=>y2_g, med=>med_g);
sort_b: sorting port map(clk=> clk, rst=> rst, y0=>y0_b, y1=>y1_b, y2=>y2_b, med=>med_b);

rom: rom_initial
  PORT MAP (
    clka => clk,
    rsta => rst,
    ena => en_rom,
    regcea => regce_rom,
    addra => addr_rom,
    douta => dout_rom
  );
  
ram: ram_operation
  PORT MAP (
    clka => clk,
    rsta => rst,
    ena => en_ram,
    regcea => regce_ram,
    wea => we_ram,
    addra => addr_ram,
    dina => din_ram,
    douta => dout_ram
  );

--------------accumulate data counter--------------
	accumulate_data: process(clk, rst)
		begin
			if(rst='1')then
				data_counter<="00";
			elsif(clk'event and clk='1')then
				if(data_counter<10#2#)then
					data_counter<= data_counter+'1';
				else
					data_counter<="00";
				end if;
			end if;
		end process;
--------------------------------------------------
	


-------------fetch the data into filter-----------
	filter: process(clk, rst)
		begin
			if(rst='1')then
				data0<=(others=>'0');
				data1<=(others=>'0');
				data2<=(others=>'0');
			elsif(clk'event and clk='1')then
				if(regce_rom='1' and en_rom='1')then
					case data_counter is
						when "00" => data0<= dout_rom(addr_rom(data_counter));
						when "01" => data1<= dout_rom(addr_rom(data_counter+10#640#));
						when "10" => data2<= dout_rom(addr_rom(data_counter+10#1280#));
					end case;
				end if;
			end if;
		end process;
----------------------------------------------------

-------------assign data every 3 clk----------------
	assign_data: process(clk, rst)
		begin
			if(rst='1')then
				data0<=(others=>'0');
				data1<=(others=>'0');
				data2<=(others=>'0');
			elsif(clk'event and clk='1')then
				if(data_counter=10#2#)then
					y0_r<= data0(7 downto 5);
					y1_r<= data1(7 downto 5);
					y2_r<= data2(7 downto 5);
					y0_g<= data0(4 downto 2);
					y1_g<= data1(4 downto 2);
					y2_g<= data2(4 downto 2);
					y0_b<= '0'&data0(1 downto 0);
					y1_b<= '0'&data1(1 downto 0);
					y2_b<= '0'&data2(1 downto 0);
				end if;
			end if;
		end process;
---------------------------------------------------

-------------take result from filter---------------					
	take_data: process(clk, rst)
		begin
			if(rst='1')then
				addr_ram<=(others=>'0');
			elsif(clk'event and clk='1')then
				if(data_counter=10#2#)then
					din_ram(addr_ram(data_counter-11))<= med_r(2 downto 0) & med_g(2 downto 0) & med_b(1 downto 0);
				end if;
			end if;
		end process;
---------------------------------------------------		

end Behavioral;

