--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:50:25 05/18/2018
-- Design Name:   
-- Module Name:   /home/binabdul/Bureau/Projet Compilo/VHDL/Compilo/DecodeurTest.vhd
-- Project Name:  Compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decodeur
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DecodeurTest IS
END DecodeurTest;
 
ARCHITECTURE behavior OF DecodeurTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decodeur
    PORT(
         instr_in : IN  std_logic_vector(31 downto 0);
         a_out : OUT  std_logic_vector(15 downto 0);
         b_out : OUT  std_logic_vector(15 downto 0);
         c_out : OUT  std_logic_vector(15 downto 0);
         op_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal instr_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal a_out : std_logic_vector(15 downto 0);
   signal b_out : std_logic_vector(15 downto 0);
   signal c_out : std_logic_vector(15 downto 0);
   signal op_out : std_logic_vector(7 downto 0);
	signal CLK : std_logic;
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decodeur PORT MAP (
          instr_in => instr_in,
          a_out => a_out,
          b_out => b_out,
          c_out => c_out,
          op_out => op_out
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		-- ADD R1 <- R9 + R4
      instr_in <= x"01010904";
      wait for 100 ns;

		-- LOAD R1 <- [ABCD]
		instr_in <= x"0701ABCD";
      wait for 100 ns;
      
		-- STORE [AABB] <- R3
		instr_in <= x"08AABB03";
      wait for 100 ns;
		
      wait;
   end process;

END;
