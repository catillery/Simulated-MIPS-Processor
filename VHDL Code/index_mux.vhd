use work.dlx_types.all;

entity index_mux is
  generic(prop_delay: Time := 5 ns);
  port (
	input_1,input_0: in register_index; 
	which: in bit; 
	output: out register_index);
end entity index_mux;

architecture behavior of index_mux is 
begin
	index_mux_behav: process(input_1, input_0, which) is 
	begin

		if which = '0' then
			output <= input_0 after prop_delay;
		else
			output <= input_1 after prop_delay;
		end if;		

	end process index_mux_behav; 
end behavior;