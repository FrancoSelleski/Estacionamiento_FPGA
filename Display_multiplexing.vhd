
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_multiplexing is
	port(
	clk,reset: in std_logic;
	i0,i1,i2,i3: in std_logic_vector (3 downto 0);
	sseg: out std_logic_vector (7 downto 0);
	an: out std_logic_vector (3 downto 0)
	);
end Display_multiplexing;

architecture Behavioral of Display_multiplexing is
signal tick_int : std_logic;
signal acum_int : unsigned(1 downto 0);
signal i_int : std_logic_vector(3 downto 0);
begin
Temp_unit: entity work.Temporizador(Behavioral)
	port map(clk=>clk,reset=>reset,tick=>tick_int,M=>to_unsigned(399999,19));
Acum_unit: entity work.Acumulador_2_bits(Behavioral)
	port map (clk=>clk,reset=>reset,en=>tick_int,acum=>acum_int);
SSeg_unit: entity work.segmentos(Behavioral)
	port map (res=>i_int,salida=>sseg);


i_int <= i0 when (acum_int="00") else
			i1 when (acum_int="01") else
			i2 when (acum_int="10") else
			i3;
an <= "1110" when(acum_int="00") else
		"1101" when (acum_int="01") else
		"1011" when (acum_int="10") else
		"0111"; 


	

end Behavioral;

