library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Contador_Autos is
generic(N: integer :=16);
port(
	clk,reset : in std_logic;
	cont : out unsigned (N-1 downto 0);
	inc,dec : in std_logic
	);
end Contador_Autos;

architecture Behavioral of Contador_Autos is
signal r_reg, r_next: unsigned(N-1 downto 0);
begin
		--Estado
	process(clk,reset)
	begin
		if(reset='1') then
			r_reg <= (others=>'0');
		elsif(clk'event and clk='1') then
			r_reg <= r_next;
		end if;
	end process;
	--logica del proximo estado
	r_next <=r_reg+1  when inc='1' else
				r_reg-1 when dec='1' else
				r_reg;
	--logica de salida
	cont <= r_reg;
	end Behavioral;

