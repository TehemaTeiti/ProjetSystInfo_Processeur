----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:40:16 05/28/2018 
-- Design Name: 
-- Module Name:    CheminDonnnees - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CheminDonnnees is
	Port ( ins_a : out STD_LOGIC_VECTOR(15 downto 0);
			  ins_di : in STD_LOGIC_VECTOR(31 downto 0);
			  data_do : out STD_LOGIC_VECTOR(15 downto 0);
			  data_a : out STD_LOGIC_VECTOR(15 downto 0);
			  data_we : out STD_LOGIC;	
			  data_di : in STD_LOGIC_VECTOR(15 downto 0);
			  CLK : in STD_LOGIC);
end CheminDonnnees;

architecture Behavioral of CheminDonnnees is

type stage is record 
	op : std_logic_vector (7 downto 0);
	a,b,c : std_logic_vector (15 downto 0);
end record;

component Pipeline 
	Port ( op_out : out STD_LOGIC_VECTOR(7 downto 0);
			  op_in	: in STD_LOGIC_VECTOR(7 downto 0);
			  A_out  : out STD_LOGIC_VECTOR(15 downto 0);
			  A_in	: in STD_LOGIC_VECTOR(15 downto 0); 
			  B_out  : out STD_LOGIC_VECTOR(15 downto 0);
			  B_in	: in STD_LOGIC_VECTOR(15 downto 0);
			  C_out  : out STD_LOGIC_VECTOR(15 downto 0);
			  C_in	: in STD_LOGIC_VECTOR(15 downto 0);
			  CLK 	: in std_logic);
end component;

component ALU 
	Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           op : in  STD_LOGIC_VECTOR(3 downto 0);
           S : out  STD_LOGIC_VECTOR(15 downto 0);
           flag : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

component BancReg 
	Port ( adA : in  STD_LOGIC_VECTOR(3 downto 0); -- addr A
           adB : in  STD_LOGIC_VECTOR(3 downto 0);
           QA : out  STD_LOGIC_VECTOR(15 downto 0); -- sortie A
           QB : out  STD_LOGIC_VECTOR(15 downto 0);
           adW : in  STD_LOGIC_VECTOR(3 downto 0);
           W : in  STD_LOGIC; -- 1 : OK pour ecrire
           Data : in  STD_LOGIC_VECTOR(15 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end component;

component Decodeur 
	Port ( instr_in : in  STD_LOGIC_VECTOR (31 downto 0);
           a_out : out  STD_LOGIC_VECTOR (15 downto 0);
           b_out : out  STD_LOGIC_VECTOR (15 downto 0);
           c_out : out  STD_LOGIC_VECTOR (15 downto 0);
           op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal d1,d2,d3,d4,d5 : stage;
signal qa,qb, mux_stage_2_s, mux_stage_3_s, mux_stage_4_s, mux_stage_5_s,alu_s : STD_LOGIC_VECTOR(15 downto 0);
signal lc_stage_5_s : STD_LOGIC;
signal lc_stage_3_s : STD_LOGIC_VECTOR (3 downto 0);

begin
	dec : Decodeur port map(Ins_di, d1.a,d1.b,d1.c,d1.op);
	lidi : Pipeline port map(d2.op, d1.op, d2.a, d1.a, d2.b, d1.b, d2.c, d1.c,CLK);
	diex : Pipeline port map(d3.op, d2.op, d3.a, d2.a, d3.b, mux_stage_2_s, d3.c, qb,CLK);
	exmem : Pipeline port map(d4.op, d3.op, d4.a, d3.a, d4.b, mux_stage_3_s, d4.c, d3.c,CLK);
	memre : Pipeline port map(d5.op, d4.op, d5.a, d4.a, d5.b, d4.b, d5.c, d4.c,CLK);
	
	br : BancReg port map(d2.b(3 downto 0), d2.c(3 downto 0), qa, qb, d4.a(3 downto 0), lc_stage_5_s, mux_stage_5_s, CLK, '1');
	alu_stage_3 : ALU port map (d3.b, d3.c, lc_stage_3_s, alu_s, open);
	
	-- LC etage 3
	lc_stage_3_s <= x"0" -- ADD
		when d3.op = x"01" else
	x"1" -- SUB
		when d3.op = x"03" else
	x"2" -- MUL
		when d3.op = x"02" else
	x"5" -- LOAD
		when d3.op = x"08"; 
		-- DIV non prise en charge par ALU
		
	-- LC etage 4
	Data_we <= '1' -- STORE
		when d4.op = x"08" else
	'0';
	
	-- LC etage 5
	lc_stage_5_s <= '1' -- ADD,MUL,SUB,DIV,AFC,COP,LOAD
		when d5.op = x"01" or d5.op = x"02" or d5.op = x"03" or d5.op = x"04" or d5.op = x"05" or d5.op = x"06" or d5.op = x"07" else
		'0';
	
	-- MUX etage 2
	mux_stage_2_s <= qa -- cas du ADD, SUB, MUL, DIV,COP
		when d2.op = x"01" or d2.op = x"02" or d2.op = x"03" or d2.op = x"04" or d2.op = x"05"  else
		d2.b; -- AFC
		
	-- MUX etage 3
	mux_stage_3_s <= alu_s 
		when d3.op = x"01" or d3.op = x"02" or d3.op = x"03" or d3.op = x"04" or d3.op = x"08" else -- cas du ADD, SUB, MUL, DIV, STORE
		d3.b; 
	
	-- MUX etage 4 (Data_a et Data_do)
	Data_a <= d4.a -- STORE
		when d4.op = x"08" else
		d4.b;
	
	Data_do <= d4.b;
	
	-- MUX etage 5
	mux_stage_5_s <= Data_di -- LOAD
		when d5.op = x"07" else 
		d5.b;
	
end Behavioral;


