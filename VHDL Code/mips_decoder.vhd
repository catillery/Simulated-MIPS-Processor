use work.bv_arithmetic.all;
use work.dlx_types.all;

-- This entity chops up a 32-bit word into the relevant component parts.
-- If a particular output is not used for a particular instruction type
-- that field is set to zero. The input from the decoder is the instruction
-- register. It operates in a purely combinational-logic mode. The controller
-- makes use of its outputs when appropriate, ignores them otherwise.
-- For R-type ALU instruction format in Figure 2.27, 
-- reg0p1 is labelled "rs" in Figure 2.27, regOp2 is labelled "rt", and
-- regDest is labelled "rd".
-- For I-type ALU instruction format in Figure 2.27
-- regOp1 is "rs" and regDest is "rt"

entity mips_decoder is
  generic(prop_delay: Time := 5 ns);
  port (
    instruction : in dlx_word;
    regOp1,regOp2,regDest: out register_index;
    alu_func: out func_code; 
    immediate: out half_word;
    opcode: out opcode_type   
  ); 
end mips_decoder;

architecture behavior of mips_decoder is 
  begin       
	mips_decoder_behav: process(instruction) is 
	variable op: opcode_type;
	variable reg1, reg2, regD: register_index;
	variable imm: half_word;
	variable func: func_code;
	begin

		op := instruction(31 downto 26);
		reg1 := instruction(25 downto 21);

		if op = "001000" or op = "001001" or op = "001010" or op = "001100" or op = "100011" then
			regD := instruction(20 downto 16);
			imm := instruction(15 downto 0);
			reg2 := "00000";
			func := "000000";
		elsif op = "101011" then
			reg2 := instruction(20 downto 16);
			imm := instruction(15 downto 0);
			regD := "00000";
			func := "000000";
		else
			reg2 := instruction(20 downto 16);
			regD := instruction(15 downto 11);
			func := instruction(5 downto 0);
			imm := "0000000000000000";
		end if;
		
		regOp1 <= reg1 after prop_delay;
		regOp2 <= reg2 after prop_delay;
		regDest <= regD after prop_delay;
		opcode <= op after prop_delay;
		immediate <= imm after prop_delay;
		alu_func <= func after prop_delay;
    
   end process mips_decoder_behav; 
end behavior;