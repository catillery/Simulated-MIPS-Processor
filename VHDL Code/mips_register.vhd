use work.dlx_types.all; 

entity mips_register is
  generic(prop_delay: Time := 5 ns);
  port (
	in_val: in dlx_word; 
	clock: in bit; 
	out_val: out dlx_word);
end entity mips_register;

architecture behavior of mips_register is 
begin

	mips_register_behav: process(in_val, clock) is 
	begin
			
		if clock = '1' then
			out_val <= in_val after prop_delay;
		end if;

	end process mips_register_behav; 
end behavior;