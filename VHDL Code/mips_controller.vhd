use work.bv_arithmetic.all;
use work.dlx_types.all;

-- This entity controls the DLX processor. It is driven by the external
-- clock signal, and takes inputs from the decoder also. It drives the
-- input of every latch on the chip, and the control input to every
-- mux, as well as sending function codes
-- to the ALU and processing ALU error codes

entity mips_controller is
  generic(prop_delay: Time := 5 ns);
  port (
    opcode: in  opcode_type;
    alu_func: in func_code;
    clock: in bit;   
    zero_out: in bit;
    aluA_mux: out bit;
    aluB_mux: out bit;
    alu_oper: out alu_operation_code;
    alu_signed: out bit; 
    write_mux: out bit;
    ir_clock: out bit;
    IM_clock: out bit; 
    pc_clock: out bit;
    npc_clock: out bit;
    imm_clock: out bit;
    alu_out_clock: out bit; 
    lmd_clock: out bit; 
    regA_clock,regB_clock: out bit;
    DM_clock: out bit;
    DM_readnotwrite: out bit;
    reg_clock: out bit;
    reg_readnotwrite: out bit;
    regA_index_mux: out bit;    
    cond_out: out bit 
    );
    
end mips_controller;

architecture behavior of mips_controller is

begin  -- behaviour

  behav: process(clock, opcode, alu_func) is
     -- current state of the machine 
     type state_type is range 1 to 5;                                
     variable state: state_type := 1;
                               
  begin       

	-- setup for mips signals based on decoder results
	if opcode = "001000" or opcode = "001001" or opcode = "001010" or opcode = "001100" or opcode = "100011" or opcode = "101011" then
		aluA_mux <= '0' after prop_delay; 
        	cond_out <= '1' after prop_delay;
		if opcode = "001000" then
			aluB_mux <= '0' after prop_delay;
			alu_oper <= "0000" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif opcode = "001001" then
			aluB_mux <= '0' after prop_delay;
			alu_oper <= "0000" after prop_delay;
			alu_signed <= '0' after prop_delay;
		elsif opcode = "001010" then
			aluB_mux <= '0' after prop_delay;
			alu_oper <= "0001" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif opcode = "001100" then
			aluB_mux <= '0' after prop_delay;
			alu_oper <= "0010" after prop_delay;
			alu_signed <= '0' after prop_delay;
		elsif opcode = "100011" or opcode = "101011" then
			aluB_mux <= '0' after prop_delay;
			alu_oper <= "0000" after prop_delay;
			alu_signed <= '0' after prop_delay; 
		end if;
	elsif opcode = "000000" then 
		if alu_func = "100000" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0000" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "100001" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0000" after prop_delay;
			alu_signed <= '0' after prop_delay;
		elsif alu_func = "100010" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0001" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "100011" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0001" after prop_delay;
			alu_signed <= '0' after prop_delay;
		elsif alu_func = "001110" then			
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "1110" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "010110" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "1110" after prop_delay;
			alu_signed <= '0' after prop_delay;
		elsif alu_func = "100100" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0010" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "100101" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "0011" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "101010" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "1011" after prop_delay;
			alu_signed <= '1' after prop_delay;
		elsif alu_func = "101011" then
			aluA_mux <= '0' after prop_delay; 
        		cond_out <= '1' after prop_delay;
			aluB_mux <= '1' after prop_delay;
			alu_oper <= "1011" after prop_delay;	
			alu_signed <= '0' after prop_delay;
		end if;
	end if;

	-- 5 stage pipeline
    	if clock'event and clock = '1' then
	-- Sources: https://www.cs.umd.edu/~meesh/cmsc411/website/handouts/Simple_Operation_of_MIPS.htm, https://www.cs.cornell.edu/courses/cs3410/2012sp/lecture/09-pipelined-cpu-i-g.pdf
        case state is 
         	when 1 =>
			-- used, MIPS instruction fetch
			IM_clock <= '1' after prop_delay; -- need to access im for initial fetch
            		ir_clock <= '1' after prop_delay; -- IR = mem[pc]
            		npc_clock <= '1' after prop_delay; -- npc + 4

            		state := 2;    
		when 2 =>
			-- used, MIPS instruction decode & register fetch
			regA_clock <= '1' after prop_delay; -- regs[ir[10..6]]
            		regB_clock <= '1' after prop_delay; -- regs[ir[11..15]
			regA_index_mux <= '0' after prop_delay;
			imm_clock <= '1' after prop_delay; -- sign_extended ir[31..16]
			reg_readnotwrite <= '1' after prop_delay; -- reading from instruction regs
			reg_clock <= '1' after prop_delay;
            		
            		state := 3; 
         	when 3 =>
			-- used, MIPS exectuion & effective address cycle
			alu_out_clock <= '1' after prop_delay; -- utilizing alu for A + imm, A op B, or A op Imm

            		state := 4;
         	when 4 =>
			-- used, memory access & branch completion
			pc_clock <= '1' after prop_delay;
            		if opcode = "101011" then
				-- store		
				DM_clock <= '1' after prop_delay; -- storing to memory value of regB if store
              			DM_readnotwrite <= '0' after prop_delay; 	
            		elsif opcode = "100011" then
				-- load
				DM_clock <= '1' after prop_delay; -- storing to memory value of regB if store
				lmd_clock <= '1' after prop_delay; -- lmd set to mem[alu result]
              			DM_readnotwrite <= '1' after prop_delay; 	
            		end if;

            		state := 5; 
         	when 5 =>
			-- used
			if opcode /= "101011" then
				-- loading
              			regA_index_mux <= '1' after prop_delay;
				reg_readnotwrite <= '0' after prop_delay; -- writing to reg[ir(...)]
				reg_clock <= '1' after 10ns; -- writing back to regfile
			end if;
           		if opcode = "100011" or opcode = "101011" then
				write_mux <= '1' after prop_delay;
			else
				write_mux <= '0' after prop_delay;
            		end if;

            		state := 1; 
         	when others => null;
       end case;
     else
       if clock'event and clock = '0' then 
    		ir_clock <= '0' after prop_delay;
    		IM_clock <= '0' after prop_delay; 
    		pc_clock <= '0' after prop_delay;
    		npc_clock <= '0' after prop_delay;
    		imm_clock <= '0' after prop_delay;
    		alu_out_clock <= '0' after prop_delay;
    		lmd_clock <= '0' after prop_delay;
    		regA_clock <= '0' after prop_delay;
		regB_clock <= '0' after prop_delay;
		DM_clock <= '0' after prop_delay;
    		reg_clock <= '0' after prop_delay;
       end if;
       
     end if;
  end process behav;                                 

end behavior;

