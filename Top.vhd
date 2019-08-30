
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top is
port(
	a,b: in std_logic;
	clk,reset : in std_logic;
	sseg: out std_logic_vector(7 downto 0);
	an: out std_logic_vector(3 downto 0)
	);
end Top;

architecture Behavioral of Top is
signal Sensor_adentro, Sensor_afuera : std_logic;
signal inc, dec : std_logic;
signal contador : unsigned(15 downto 0);
begin
Sensor_Adentro_unit : entity work.db_fsm(arch)
		port map (clk => clk, reset => reset, sw => a, db =>Sensor_adentro);
Sensor_afuera_unit : entity work.db_fsm(arch)
		port map (clk => clk, reset => reset, sw => b, db =>Sensor_afuera);
Maquina_de_estados_unit: entity work.Maquina_Sensores(Behavioral)
		port map (clk => clk, reset => reset, a=>Sensor_adentro, b=>Sensor_afuera, inc=>inc, dec=>dec);
Contador_unit : entity work.Contador_Autos(Behavioral)
		port map (clk => clk, reset => reset, inc => inc, dec => dec, cont=>contador);
Display_unit: entity work.Display_multiplexing(Behavioral)
		port map (i0=>std_logic_vector(contador(3 downto 0)),i1=>std_logic_vector(contador(7 downto 4)),i2=>std_logic_vector(contador(11 downto 8)),i3=>std_logic_vector(contador(15 downto 12)),clk=>clk,reset=>reset,sseg=>sseg,an=>an);


end Behavioral;

