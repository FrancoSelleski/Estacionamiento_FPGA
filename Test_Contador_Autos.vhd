LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Test_Contador_Autos IS
END Test_Contador_Autos;
 
ARCHITECTURE behavior OF Test_Contador_Autos IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Contador_Autos
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         cont : OUT  unsigned(15 downto 0);
         inc : IN  std_logic;
         dec : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal inc : std_logic := '0';
   signal dec : std_logic := '0';

 	--Outputs
   signal cont : unsigned(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Contador_Autos PORT MAP (
          clk => clk,
          reset => reset,
          cont => cont,
          inc => inc,
          dec => dec
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
        -- hold reset state for 15 ns.
			reset <='1';
      wait for 15 ns;
		wait until falling_edge(clk);
		
		reset <='0';
		
		--suma 2
		inc<='1';
		wait for 2*clk_period;
		inc<='0';
		wait for 3*clk_period;
		
		assert (cont=2) report "Fallo la suma de 2" severity failure;
		
		dec<='1';
		wait for clk_period;
		dec<='0';
		wait for 3*clk_period;
		
		assert (cont=1) report "Fallo la salida de uno" severity failure;
		
		assert false report "BOKE" severity failure;

      -- insert stimulus here 


   end process;

END;
