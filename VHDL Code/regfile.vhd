use work.bv_arithmetic.all;
use work.dlx_types.all;

entity regfile is
	generic(prop_delay: Time := 5 ns);
	port (read_notwrite, clock: in bit; regA, regB: in register_index; 
			data_in: in dlx_word; dataA_out, dataB_out: out dlx_word);
end entity regfile;

architecture behavior of regfile is 
	type memory is array (0 to 31) of dlx_word;
	signal memory_array : memory;
begin
	regfile_behav : process (read_notwrite, clock, regA, regB) is
	begin
	
		if read_notwrite = '0' then
			if clock = '1' then
				memory_array(bv_to_integer(bv => regA)) <= data_in after prop_delay;
			end if;
		else
			dataA_out <= memory_array(bv_to_integer(bv => regA)) after prop_delay;
			dataB_out <= memory_array(bv_to_integer(bv => regB)) after prop_delay;
		end if;
		
	end process regfile_behav; 
end architecture behavior;