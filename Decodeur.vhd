----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:34 05/18/2018 
-- Design Name: 
-- Module Name:    Decodeur - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decodeur is
    Port ( instr_in : in  STD_LOGIC_VECTOR (31 downto 0);
           a_out : out  STD_LOGIC_VECTOR (15 downto 0);
           b_out : out  STD_LOGIC_VECTOR (15 downto 0);
           c_out : out  STD_LOGIC_VECTOR (15 downto 0);
           op_out : out  STD_LOGIC_VECTOR (7 downto 0));
end Decodeur;

architecture Behavioral of Decodeur is

begin
	op_out <= instr_in(31 downto 24);
	
	a_out <= instr_in(23 downto 8)
		when instr_in(31 downto 24) = x"08" else
		x"00"&instr_in(23 downto 16);
		
	b_out <= instr_in(15 downto 0)
		when instr_in(31 downto 24) = x"07" or instr_in(31 downto 24) = x"06" else
		x"0000"
		when instr_in(31 downto 24) = x"08" else
		x"00"&instr_in(15 downto 8);
		
	c_out <= x"0000"
		when instr_in(31 downto 24) = x"07" or instr_in(31 downto 24) = x"06" else
		x"00"&instr_in(7 downto 0);
		
end Behavioral;

