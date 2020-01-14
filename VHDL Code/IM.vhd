use work.dlx_types.all;
use work.bv_arithmetic.all;

entity IM is
  port (
	address: in dlx_word; 
	instruction: out dlx_word; 
	clock: in bit);
end IM;

architecture behavior of IM is 

begin

  IM_behav: process(address,clock) is
    type memtype is array (0 to 1024) of dlx_word;
    variable instr_memory : memtype;                   
  begin
    -- fill this in by hand to put some values in there
    -- first instr is 'LW R1,4092(R0)' 
    instr_memory(0) := B"10001100000000010000111111111100";
    -- next instr is 'ADD R2,R1,R1'
    instr_memory(1) := B"00000000001000010001000000100000";
    instr_memory(2) := B"10101100000000100000000000010000";
    instr_memory(3) := B"10001100000000110000000000010000";
    -- next instr is 'ADDU R2,R1,R1'
    instr_memory(4) := B"10001100000000010000111111111100";
    instr_memory(5) := B"00000000001000010001000000100001";
    instr_memory(6) := B"10101100000000100000000000010000";
    instr_memory(7) := B"10001100000000110000000000010000"; 
    
    if clock'event and clock = '1' then
        -- do a read
        instruction <= instr_memory(bv_to_natural(address)/4);
    end if;
  end process IM_behav; 

end behavior;
