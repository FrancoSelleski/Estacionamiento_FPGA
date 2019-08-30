LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Test_Maquina_Sensores IS
END Test_Maquina_Sensores;
 
ARCHITECTURE behavior OF Test_Maquina_Sensores IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Maquina_Sensores
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  std_logic;
         b : IN  std_logic;
         inc : OUT  std_logic;
         dec : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal inc : std_logic;
   signal dec : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Maquina_Sensores PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          b => b,
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


      --entra uno
		reset <='0';
		a <='1';
		b <= '0';
		wait for clk_period;
		a <='1';
		b <= '1';
		wait for clk_period;
		a <='0';
		b <= '1';
		wait for clk_period;
		a <='0';
		b <= '0';
		wait for clk_period;

		assert (inc ='1' and dec='0') report "Fallo entrada" severity failure;
		
		wait for clk_period;
		
		--sale uno
		a <='0';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '0';
		wait for clk_period;
		a <='0';
		b <= '0';
		wait for clk_period;
		
		assert (inc ='0' and dec='1') report "Fallo salida" severity failure;
		
		--falta paso final
		a <='0';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '0';
		wait for clk_period;
		
		assert (inc ='0' and dec='0') report "Fallo falta paso final" severity failure;
		
		--falta paso intermedio
		a <='0';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '1';
		wait for clk_period;
		a <='0';
		b <= '0';
		wait for clk_period;
		
		assert (inc ='0' and dec='0') report "Fallo falta paso intermedio" severity failure;
		
		--falta el primer paso
		a <='1';
		b <= '1';
		wait for clk_period;
		a <='1';
		b <= '0';
		wait for clk_period;
		a <='0';
		b <= '0';
		wait for clk_period;
		
		assert (inc ='0' and dec='0') report "Fallo falta primer paso" severity failure;
		
		assert false report "BOKE" severity failure;
      wait;
   end process;

END;
