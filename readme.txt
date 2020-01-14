#########################################################################
In order to test the functionality of the MIPS processor, I edited the 
IM file to carry out each of the supported instructions. For simplicity,
I used the formatting and registers from the example instructions.
The included screenshots show the matching opcode, function code, and 
ALU operation that correspond to the command. This shows that steps 1-3
of the MIPS pipeline are working properly.

Feel free to run any of these instructions to test for correctness. Add
the components of the mips entity to the wave and set the MIPS clock to 
a cycle of 200ns and run -all.

I have also included a memory snapshot of the regfile, DM, and IM to
that steps 4-5 of the MIPS pipeline are functioning as well (the snapshot
provided is for the first 0 - 7 instructions).

-------------------------------------------------------------------------
Here is the code for the simulations:
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
    -- next instr is 'ADDI R2,1'
    instr_memory(8) := B"10001100000000010000111111111100";
    instr_memory(9) := B"00100000001000010000000000000001";
    instr_memory(10) := B"10101100000000100000000000010000";
    instr_memory(11) := B"10001100000000110000000000010000"; 
    -- next instr is 'ADDUI R2,1'
    instr_memory(12) := B"10001100000000010000111111111100";
    instr_memory(13) := B"00100100001000010000000000000001";
    instr_memory(14) := B"10101100000000100000000000010000";
    instr_memory(15) := B"10001100000000110000000000010000"; 
    -- next instr is 'SUB R2,R1,R1'
    instr_memory(16) := B"10001100000000010000111111111100";
    instr_memory(17) := B"00000000001000010000000000100010";
    instr_memory(18) := B"10101100000000100000000000010000";
    instr_memory(19) := B"10001100000000110000000000010000"; 
    -- next instr is 'SUBI R2,1'
    instr_memory(20) := B"10001100000000010000111111111100";
    instr_memory(21) := B"00101000001000010000000000000001";
    instr_memory(22) := B"10101100000000100000000000010000";
    instr_memory(23) := B"10001100000000110000000000010000"; 
    -- next instr is 'SUBU R2,R1,R1'
    instr_memory(24) := B"10001100000000010000111111111100";
    instr_memory(25) := B"00000000001000010000000000100011";
    instr_memory(26) := B"10101100000000100000000000010000";
    instr_memory(27) := B"10001100000000110000000000010000"; 
    -- next instr is 'MUL R2,R1,R1'
    instr_memory(28) := B"10001100000000010000111111111100";
    instr_memory(29) := B"00000000001000010000000000001110";
    instr_memory(30) := B"10101100000000100000000000010000";
    instr_memory(31) := B"10001100000000110000000000010000"; 
    -- next instr is 'MULU R2,R1,R1'
    instr_memory(32) := B"10001100000000010000111111111100";
    instr_memory(33) := B"00000000001000010000000000010110";
    instr_memory(34) := B"10101100000000100000000000010000";
    instr_memory(35) := B"10001100000000110000000000010000"; 
    -- next instr is 'AND R2,R1,R1'
    instr_memory(36) := B"10001100000000010000111111111100";
    instr_memory(37) := B"00000000001000010001000000100100";
    instr_memory(38) := B"10101100000000100000000000010000";
    instr_memory(39) := B"10001100000000110000000000010000"; 
    -- next instr is 'OR R2,R1,R1'
    instr_memory(40) := B"10001100000000010000111111111100";
    instr_memory(41) := B"00000000001000010001000000100101";
    instr_memory(42) := B"10101100000000100000000000010000";
    instr_memory(43) := B"10001100000000110000000000010000"; 
    -- next instr is 'ANDI R2,1'
    instr_memory(44) := B"10001100000000010000111111111100";
    instr_memory(45) := B"00110000001000010000000000000001";
    instr_memory(46) := B"10101100000000100000000000010000";
    instr_memory(47) := B"10001100000000110000000000010000";
    -- next instr is 'SLT R2,R1,R1'
    instr_memory(48) := B"10001100000000010000111111111100";
    instr_memory(49) := B"00000000001000010001000000101010";
    instr_memory(50) := B"10101100000000100000000000010000";
    instr_memory(51) := B"10001100000000110000000000010000"; 
    -- next instr is 'SLTU R2,R1,R1'
    instr_memory(52) := B"10001100000000010000111111111100";
    instr_memory(53) := B"00000000001000010001000000101011";    
    instr_memory(54) := B"10101100000000100000000000010000";
    instr_memory(55) := B"10001100000000110000000000010000";  

