--
-- VHDL Architecture riscvio_lib.dyn_branch_unit.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 13:07:30 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF dyn_branch_unit IS
BEGIN
    -- dbta_valid needs to clear if, dc registers
    process(all) is
    begin
        case ctrl_sig.mnemonic is
            when beq => 
                dbta_valid <= alu_flags.eq;
            when bne =>
                dbta_valid <= NOT alu_flags.eq;
            when blt => 
                dbta_valid <= alu_flags.altb;
            when bge => 
                dbta_valid <= not alu_flags.altb or alu_flags.eq;
            when bltu => 
                dbta_valid <= alu_flags.altbu;
            when bgeu => 
                dbta_valid <= not alu_flags.altbu or alu_flags.eq;
            when others => 
                dbta_valid <= false;
        end case;
    end process;

    dbta <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + to_integer(signed(imm)), WORD_SIZE));
END ARCHITECTURE behav;

