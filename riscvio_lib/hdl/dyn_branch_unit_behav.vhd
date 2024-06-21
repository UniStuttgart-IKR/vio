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
    signal rix_int: word_T;
    subtype rix_raw_T is std_logic_vector(word_T'high downto 1);
BEGIN
    rix_int <= rix_raw_T(unsigned(pc.ix) + 4) & '1' when pc.ix(0) = '0' else
               rix_raw_T(unsigned(pc.ix) + 4) & '1' when pc.ix(0) = '1';

    -- dbta_valid needs to clear if, dc registers
    process(all) is
    begin
        state_error <= false;
        ra_out <= REG_MEM_NULL;
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
                ra_out <= (tag => POINTER, data => ra_in.val, pi => rix_int, delta => ra_in.dt);
                state_error <= (frame.val(0) = ra_in.pi(0) and rdst_ix = ali_T'pos(ra)) or (frame.val(0) /= ra_in.pi(0) and rdat.ali = rix);
            when jal => 
                dbt_valid <= false;
                ra_out <= (tag => POINTER, data => ra_in.val, pi => rix_int, delta => ra_in.dt);
                state_error <= frame.val(0) = ra_in.pi(0) and rdst_ix = ali_T'pos(ra);
            when others => 
                dbt_valid <= false;
        end case;
    end process;

    dbt.ix <= std_logic_vector(to_unsigned(to_integer(unsigned(pc.ix)) + to_integer(signed(imm)), WORD_SIZE)) when branch_mode /= jalr else rdat.val(word_T'high downto 1) & '0';
    dbt.ptr <= pc.ptr;
    dbt.pi <= pc.pi;
    dbt.dt <= pc.dt;
END ARCHITECTURE behav;

