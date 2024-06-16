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
        case branch_mode is
            when beq => 
                dbt_valid <= alu_flags.eq;
            when bne =>
                dbt_valid <= NOT alu_flags.eq;
            when blt => 
                dbt_valid <= alu_flags.altb;
            when bge => 
                dbt_valid <= not alu_flags.altb or alu_flags.eq;
            when bltu => 
                dbt_valid <= alu_flags.altbu;
            when bgeu => 
                dbt_valid <= not alu_flags.altbu or alu_flags.eq;
            when jalr => 
                dbt_valid <= true;
            when others => 
                dbt_valid <= false;
        end case;
    end process;

    dbt.ix <= std_logic_vector(to_unsigned(to_integer(unsigned(pc.ix)) + to_integer(signed(imm)), WORD_SIZE)) when branch_mode /= jalr else dyn_branch_tgt;
    dbt.ptr <= pc.ptr;
    dbt.pi <= pc.pi;
    dbt.dt <= pc.dt;
END ARCHITECTURE behav;

