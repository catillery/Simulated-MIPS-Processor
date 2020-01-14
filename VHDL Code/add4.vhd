use work.bv_arithmetic.all;
use work.dlx_types.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity add4 is
	generic(prop_delay: Time := 5 ns);
	port (input: in dlx_word; output: out dlx_word);
end entity add4;

architecture behavior of add4 is 
begin
	add4_behav : process (input) is
	begin

		output <= integer_to_bv(int => bv_to_integer(bv => input) + 4, length => 32) after prop_delay;

	end process add4_behav; 
end architecture behavior; 