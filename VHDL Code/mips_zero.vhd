use work.dlx_types.all; 

entity mips_zero is
  generic(prop_delay: Time := 5 ns);
  port (
	input: in dlx_word;
	output: out bit);
end mips_zero;

architecture behavior of mips_zero is 
begin
	mips_zero_behav: process(input) is 
	begin
		
		if input = "00000000000000000000000000000000" then
			output <= '1' after prop_delay;
		else
			output <= '0' after prop_delay;
		end if;
		
	end process mips_zero_behav; 
end behavior;