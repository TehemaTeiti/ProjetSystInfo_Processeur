--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:03:05 05/03/2018
-- Design Name:   
-- Module Name:   /home/binabdul/Bureau/Projet Compilo/VHDL/Compilo/testVHDL.vhd
-- Project Name:  Compilo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY testVHDL IS
END testVHDL;
 
ARCHITECTURE behavior OF testVHDL IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         flag : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal flag : std_logic_vector(3 downto 0);
	signal CLK : std_logic;
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          op => op,
          S => S,
          flag => flag
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
		-- 3+4=7
      A <= x"0003";
		B <= x"0004";
		op <= x"0";
      wait for 100 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
