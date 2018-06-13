--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:12:47 06/01/2018
-- Design Name:   
-- Module Name:   /home/binabdul/Bureau/Projet Compilo/VHDL/Compilo/CheminDonneesTest.vhd
-- Project Name:  Compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CheminDonnnees
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
 
ENTITY CheminDonneesTest IS
END CheminDonneesTest;
 
ARCHITECTURE behavior OF CheminDonneesTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CheminDonnnees
    PORT(
         ins_a : OUT  std_logic_vector(15 downto 0);
         ins_di : IN  std_logic_vector(31 downto 0);
         data_do : OUT  std_logic_vector(15 downto 0);
         data_a : OUT  std_logic_vector(15 downto 0);
         data_we : OUT  std_logic;
         data_di : IN  std_logic_vector(15 downto 0);
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');
   signal data_di : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal ins_a : std_logic_vector(15 downto 0);
   signal data_do : std_logic_vector(15 downto 0);
   signal data_a : std_logic_vector(15 downto 0);
   signal data_we : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CheminDonnnees PORT MAP (
          ins_a => ins_a,
          ins_di => ins_di,
          data_do => data_do,
          data_a => data_a,
          data_we => data_we,
          data_di => data_di,
          CLK => CLK
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
--	   -- test AFC R1 <- 2 (R1=2)
--		ins_di <= x"06010002";
--      wait for 100 ns;
	
		Data_di <= x"ABCD";
		ins_di <= x"0701F00D";
		wait for 100 ns;
	
--		-- test COP R2 <- R1 (R2=2)
--		ins_di <= x"05020100";
--		wait for 100 ns;
--		
--		-- test ADD R3 <- R2 + R1 (R3=4)
--		ins_di <= x"01030102";
--		wait for 100 ns;
--		
--		-- test MUL R4 <- R2 * R3 (R4=8)
--		ins_di <= x"02040203";
--		wait for 100 ns;
--		
--		-- test SUB R5 <- R4 - R3 (R5=4)
--		ins_di <= x"03050403";
--		wait for 100 ns;
--		
--		-- test AFC R5 <- FE (R5 = 5)
--		ins_di <= x"060500FE";
--		wait for 100 ns;
--		
--		-- test LOAD R6 <- [F00D]  (=ABCD)
--		Data_di <= x"ABCD";
--		ins_di <= x"0706F00D";
--		wait for 100 ns;
--	
--		-- test STORE [FEED] <- R5 (=FE)
--		ins_di <= x"08FEED05";
--		wait for 100 ns;
		
      wait;
   end process;

END;
