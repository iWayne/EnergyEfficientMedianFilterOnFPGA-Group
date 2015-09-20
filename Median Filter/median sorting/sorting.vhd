library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sorting is
	generic(n: integer :=3);
	port(
		clk: in std_logic;
		rst: in std_logic;
		y0: in std_logic_vector (n-1 downto 0);
		y1: in std_logic_vector (n-1 downto 0);
		y2: in std_logic_vector (n-1 downto 0);
		med: out std_logic_vector(n-1 downto 0);
		
		------test----
		cx2, cx5, cx8: out std_logic_vector(n-1 downto 0);
		cx1, cx4, cx7: out std_logic_vector(n-1 downto 0);
		cx0, cx3, cx6: out std_logic_vector(n-1 downto 0);
		cp1, cp2, cp3, cp4, cp5, cp6: out std_logic_vector(n-1 downto 0);
		cp7, cp8, cp11, cp13, cp16, cp17, cp20: out std_logic_vector(n-1 downto 0);
		cp9, cp12, cp14, cp18, cp10, cp15, cp19: out std_logic_vector(n-1 downto 0);
		cp21, cp23, cp25, cp22, cp24: out std_logic_vector(n-1 downto 0)
		
	);
end sorting;

architecture Behavioral of sorting is
--------------signal btw REGs----------------------
signal x0, x1, x2: std_logic_vector (n-1 downto 0):= (others => '0');
signal x3, x4, x5: std_logic_vector (n-1 downto 0):= (others => '0');
signal x6, x7, x8: std_logic_vector (n-1 downto 0):= (others => '0');
-------------px for inter signal-------------------
signal p1, p2, p3, p4, p5: std_logic_vector (n-1 downto 0):= (others => '0');
signal p6, p7, p8, p9, p10: std_logic_vector (n-1 downto 0):= (others => '0');
signal p11, p12, p13, p14, p15: std_logic_vector (n-1 downto 0):= (others => '0');
signal p16, p17, p18, p19, p20: std_logic_vector (n-1 downto 0):= (others => '0');
signal p21, p22, p23, p24, p25, luca: std_logic_vector (n-1 downto 0):= (others => '0');

-------------------call PE-------------------------
component PE is
generic(n: integer :=3);
port(
    clk  : in std_logic;
	 rst  : in std_logic;
	 load : in std_logic;
	 A    : in std_logic_vector(n-1 downto 0);
	 B    : in std_logic_vector(n-1 downto 0);
	 H    : out std_logic_vector(n-1 downto 0);
	 L    : out std_logic_vector(n-1 downto 0)
	 );
end component;

signal load: std_logic;
---------------------------------------------------	

------------------call reg-------------------------
component regifile is
generic(n: integer :=3);
port(
     I     :in std_logic_vector(n-1 downto 0);
	  clk   :in std_logic;
	  rst   :in std_logic;
	  load  :in std_logic;
	  Q     :out std_logic_vector(n-1 downto 0)
	  );
end component;
signal I0, I1, I2, I3, I4: std_logic_vector(n-1 downto 0);
signal I5, I6, I7, I8, I9: std_logic_vector(n-1 downto 0);
signal I10, I11, I12: std_logic_vector(n-1 downto 0);
signal Q0, Q1, Q2, Q3, Q4: std_logic_vector(n-1 downto 0);
signal Q5, Q6, Q7, Q8, Q9: std_logic_vector(n-1 downto 0);
signal Q10, Q11, Q12: std_logic_vector(n-1 downto 0);
---------------------------------------------------


begin
load<='1';
------------------------------------REGISTERS------------------------------------
R0: regifile port map(I=>p1, clk=> clk, rst=>rst, load=>load, Q=>p2);
R1: regifile port map(I=>y2, clk=> clk, rst=>rst, load=>load, Q=>luca);
R1_add: regifile port map(I=>luca, clk=> clk, rst=>rst, load=>load, Q=>p5);
R2: regifile port map(I=>p6, clk=> clk, rst=>rst, load=>load, Q=>x8);
R3: regifile port map(I=>x2, clk=> clk, rst=>rst, load=>load, Q=>x1);
R4: regifile port map(I=>x5, clk=> clk, rst=>rst, load=>load, Q=>x4);
R5: regifile port map(I=>x8, clk=> clk, rst=>rst, load=>load, Q=>x7);
R6: regifile port map(I=>x1, clk=> clk, rst=>rst, load=>load, Q=>x0);
R7: regifile port map(I=>x4, clk=> clk, rst=>rst, load=>load, Q=>x3);
R8: regifile port map(I=>x7, clk=> clk, rst=>rst, load=>load, Q=>x6);
R9: regifile port map(I=>x2, clk=> clk, rst=>rst, load=>load, Q=>p8);
R10: regifile port map(I=>p9, clk=> clk, rst=>rst, load=>load, Q=>p10);
R11: regifile port map(I=>p11, clk=> clk, rst=>rst, load=>load, Q=>p12);
R12: regifile port map(I=>x5, clk=> clk, rst=>rst, load=>load, Q=>p16);
R13: regifile port map(I=>x6, clk=> clk, rst=>rst, load=>load, Q=>p17);
R14: regifile port map(I=>p18, clk=> clk, rst=>rst, load=>load, Q=>p19);
R15: regifile port map(I=>p21, clk=> clk, rst=>rst, load=>load, Q=>p22);
R16: regifile port map(I=>p19, clk=> clk, rst=>rst, load=>load, Q=>p25);
---------------------------------------------------------------------------------
----------------------------------PES--------------------------------------------
uut0: PE port map(clk=>clk, rst=>rst, load=>load, A=> y0, B=> y1, H=> p1, L=> p3);
uut1: PE port map(clk=>clk, rst=>rst, load=>load, A=> p3, B=> p5, H=> p4, L=> p6);
uut2: PE port map(clk=>clk, rst=>rst, load=>load, A=> p2, B=> p4, H=> x2, L=> x5);
uut3: PE port map(clk=>clk, rst=>rst, load=>load, A=> x0, B=> x1, L=> p7);
uut4: PE port map(clk=>clk, rst=>rst, load=>load, A=> p7, B=> p8, L=> p9);
uut5: PE port map(clk=>clk, rst=>rst, load=>load, A=> x3, B=> x4, H=> p11, L=> p13);
uut6: PE port map(clk=>clk, rst=>rst, load=>load, A=> p13, B=> p16, H=> p14);
uut7: PE port map(clk=>clk, rst=>rst, load=>load, A=> p12, B=> p14, L=> p15);
uut8: PE port map(clk=>clk, rst=>rst, load=>load, A=> x7, B=> x8, H=> p20);
uut9: PE port map(clk=>clk, rst=>rst, load=>load, A=> p17, B=> p20, H=> p18);
uut10: PE port map(clk=>clk, rst=>rst, load=>load, A=> p10, B=> p15, H=> p21, L=> p23);
uut11: PE port map(clk=>clk, rst=>rst, load=>load, A=> p23, B=> p25, H=> p24);
uut12: PE port map(clk=>clk, rst=>rst, load=>load, A=> p22, B=> p24, L=> med);
---------------------------------------------------------------------------------

--1st
cp1<=p1; cp2<=p2; cp3<=p3; 
--2nd
cp4<=p4; cp5<= p5; cp6<= p6;
--3rd
cx2<=x2; cx5<= x5; cx8<= x8;
--4th
cx1<=x1; cx4<=x4; cx7<=x7;
--5th
cx0<=x0; cx3<=x3; cx6<=x6;
--6th
cp7<=p7; cp8<=p8; cp11<= p11; cp13<=p13; cp16<=p16; cp17<=p17; cp20<= p20;
--7th
cp9<=p9; cp12<=p12; cp14<=p14; cp18<=p18;
--8th
cp10<=p10; cp15<=p15; cp19<=p19;
--9th
cp21<=p21; cp23<=p23; cp25<=p25;
--10th
cp22<=p22; cp24<=p24;

end Behavioral;

