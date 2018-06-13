--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:21:08 05/04/2018
-- Design Name:   
-- Module Name:   /home/binabdul/Bureau/Projet Compilo/VHDL/Compilo/PipelineTest.vhd
-- Project Name:  Compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
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
 
ENTITY PipelineTest IS
END PipelineTest;
 
ARCHITECTURE behavior OF PipelineTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipeline
    PORT(
         op_out : OUT  std_logic_vector(7 downto 0);
         op_in : IN  std_logic_vector(7 downto 0);
         A_out : OUT  std_logic_vector(15 downto 0);
         A_in : IN  std_logic_vector(15 downto 0);
         B_out : OUT  std_logic_vector(15 downto 0);
         B_in : IN  std_logic_vector(15 downto 0);
         C_out : OUT  std_logic_vector(15 downto 0);
         C_in : IN  std_logic_vector(15 downto 0);
			CLK 	: in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal op_in : std_logic_vector(7 downto 0) := (others => '0');
   signal A_in : std_logic_vector(15 downto 0) := (others => '0');
   signal B_in : std_logic_vector(15 downto 0) := (others => '0');
   signal C_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal op_out : std_logic_vector(7 downto 0);
   signal A_out : std_logic_vector(15 downto 0);
   signal B_out : std_logic_vector(15 downto 0);
   signal C_out : std_logic_vector(15 downto 0);
	signal CLK : std_logic;
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          op_out => op_out,
          op_in => op_in,
          A_out => A_out,
          A_in => A_in,
          B_out => B_out,
          B_in => B_in,
          C_out => C_out,
          C_in => C_in,
			 CLK 	=> CLK
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
      op_in <= x"01";
		A_in <= x"0002";
		B_in <= x"0003";
		C_in <= x"0004";
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
