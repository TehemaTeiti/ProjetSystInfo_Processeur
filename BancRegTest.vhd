--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:07:14 05/04/2018
-- Design Name:   
-- Module Name:   /home/binabdul/Bureau/Projet Compilo/VHDL/Compilo/BancRegTest.vhd
-- Project Name:  Compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BancReg
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
 
ENTITY BancRegTest IS
END BancRegTest;
 
ARCHITECTURE behavior OF BancRegTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BancReg
    PORT(
         adA : IN  std_logic_vector(3 downto 0);
         adB : IN  std_logic_vector(3 downto 0);
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0);
         adW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         Data : IN  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal adA : std_logic_vector(3 downto 0) := (others => '0');
   signal adB : std_logic_vector(3 downto 0) := (others => '0');
   signal adW : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal Data : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancReg PORT MAP (
          adA => adA,
          adB => adB,
          QA => QA,
          QB => QB,
          adW => adW,
          W => W,
          Data => Data,
          CLK => CLK,
          RST => RST
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
		-- R1 <- 7
		RST <= '1';
		adA <= x"0";
		adB <= x"1";
		W <= '1';
		
		adW <= x"1";
		DATA <= x"0007";
      wait for 100 ns;	

		-- R0 <- 9
		adW <= x"0";
		DATA <= x"0009";
		wait for 100 ns;
		
		-- Sortir 7 de QA (valeur de R1)
		W <= '0';
		adA <= x"1";
		wait for 100 ns;
		
		-- Rall <- 0
		RST <= '0';
		wait for 100 ns;
		
		-- ???
		adA <= x"2";
		adB <= x"3";
		wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
