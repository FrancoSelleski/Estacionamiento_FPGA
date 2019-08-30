library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Maquina_Sensores is
port(
	clk,reset : in std_logic;
	a,b: in std_logic;
	inc,dec: out std_logic
	);
end Maquina_Sensores;

architecture Behavioral of Maquina_Sensores is
type estado_sensores is (quieto,ent_10,ent_11,ent_01,sal_01,sal_11,sal_10,entro,salio);
signal r_reg,r_next : estado_sensores;
begin
 --Estado
process(clk,reset)
	begin
		if(reset='1') then
			r_reg <= quieto;
		elsif(clk'event and clk='1') then
			r_reg <= r_next;
		end if;
	end process;
--Logica del estado siguiente

process(r_reg,a,b)
begin
	--Proceso de entrada
	case r_reg is 
	when quieto =>
			if a = '1' and  b = '0' then
				r_next <= ent_01;
			elsif(a='0' and b='1')then
				r_next <= sal_10;
			else
				r_next <= r_reg;
			end if;
	when ent_01 =>
			if ( a='1' and b='1') then
				r_next <= ent_11;
			elsif (a='1' and b='0') then
				r_next <= r_reg;
			else
				r_next <= quieto;
			end if;
	when ent_11 =>
			if(a='0' and b='1') then
				r_next <= ent_10;
			elsif (a='1' and b='1') then
				r_next <= r_reg;
			elsif (a='1' and b='0') then
				r_next <= ent_01;
			else
				r_next <= quieto;
			end if;
	when ent_10 =>
			if(a='0' and b='0') then
				r_next <= entro;
			elsif(a='1' and b='1') then
				r_next <= ent_11;
			elsif(a='0' and b='1') then
				r_next <= r_reg;
			else 
				r_next <= quieto;
			end if;
	
			
	--Proceso de salida
	when sal_10 =>
			if(a='1' and b='1') then
				r_next <= sal_11;
			elsif (a='0' and b='1')  then
				r_next <= r_reg;
			else
				r_next <= quieto;
			end if;
	when sal_11 =>
			if (a='1' and b='0') then
				r_next <= sal_01;
			elsif (a='1' and b='1') then
				r_next <= r_reg;
			elsif (a='0' and b='1') then
				r_next <= sal_10;
			else 
				r_next <= quieto;
			end if;
	when sal_01 =>
			if(a='0' and b='0') then
				r_next <= salio;
			elsif (a='1' and b='1') then
				r_next <= sal_11;
			elsif (a='1' and b='0') then
				r_next <= r_reg;
			else 
				r_next <= quieto;
			end if;
	when entro =>
			r_next <= quieto;
	when salio => 
			r_next <= quieto;
	when others =>
		r_next <= r_reg;
			
	end case;
end process;

--Logica de salida
process(r_reg)
begin
case r_reg is
	when entro =>
		inc<= '1';
	when salio =>
		dec <= '1';
	when others => 
		dec <= '0';
		inc <= '0';
	end case;
end process;

end Behavioral;

