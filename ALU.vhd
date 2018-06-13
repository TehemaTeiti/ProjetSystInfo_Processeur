----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:13:25 05/03/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           op : in  STD_LOGIC_VECTOR(3 downto 0);
           S : out  STD_LOGIC_VECTOR(15 downto 0);
           flag : out  STD_LOGIC_VECTOR(3 downto 0));
end ALU;

architecture Behavioral of ALU is

signal Smul : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";

begin

	S <= A+B -- ADD
		when op = "0000" else
		  
	A-B -- SUB
		when op = "0001" else
	
	Smul(15 downto 0) -- Smul est sur 32 bits
		when op = "0010" else

	'0'&A(15 downto 1) -- decalage droite
		when op = "0011" else
	
	A(14 downto 0)&'0' -- decalage gauche
		when op = "0100" else

	B -- LOAD
		when op = "0101";
		
	Smul <= A*B;
	
end Behavioral;

