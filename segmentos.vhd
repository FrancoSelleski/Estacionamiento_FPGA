library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity segmentos is
port(
	res: in std_logic_vector(3 downto 0);
	salida: out std_logic_vector(7 downto 0)
	);
end segmentos;

architecture Behavioral of segmentos is

begin
with res select
salida(6 downto 0) <= "1000000" when "0000",
							 "1111001" when "0001",
							 "0100100" when "0010",
							 "0110000" when "0011",
							 "0011001" when "0100",
							 "0010010" when "0101",
							 "0000010" when "0110",
							 "1111000" when "0111",
							 "0000000" when "1000",
							 "0011000" when "1001",
							 "0100000" when "1010", --a
							 "0000011" when "1011", --b
							 "0100111" when "1100", --c
							 "0100001" when "1101", --d
							 "0000100" when "1110", --e
							 "0001110" when others; --f es la unica combinacion que queda
							 				 

salida(7) <= '1';  -- el puntito del 7 segmentos 

end Behavioral;

