----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:34:36 05/04/2018 
-- Design Name: 
-- Module Name:    BancReg - Behavioral 
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
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancReg is
    Port ( adA : in  STD_LOGIC_VECTOR(3 downto 0); -- addr A
           adB : in  STD_LOGIC_VECTOR(3 downto 0);
           QA : out  STD_LOGIC_VECTOR(15 downto 0); -- sortie A
           QB : out  STD_LOGIC_VECTOR(15 downto 0);
           adW : in  STD_LOGIC_VECTOR(3 downto 0);
           W : in  STD_LOGIC; -- 1 : OK pour ecrire
           Data : in  STD_LOGIC_VECTOR(15 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC); -- rst active à 0
end BancReg;

architecture Behavioral of BancReg is

type reg is array (integer range <>) of STD_LOGIC_VECTOR(15 downto 0); -- tab de 16 reg de 16 bits
signal table : reg(0 to 15);

begin
	process	
	begin 
		wait until CLK'event and CLK = '1';
		if (RST = '0') then
			for i in 0 to 15 loop
				table(i) <= x"0000";
			end loop;
		elsif (RST = '1') and (W = '1') then 
			table(to_integer(unsigned(adW))) <= DATA;
		end if;
	end process;

	QA <= DATA
		when RST='1' and W='1' and (adA = adW) else
	x"0000"
		when RST='0' else
	table(to_integer(unsigned(adA)));
	
	QB <= DATA
		when RST='1' and W='1' and (adB = adW) else
	x"0000"
		when RST='0' else
	table(to_integer(unsigned(adB)));
		

end Behavioral;

