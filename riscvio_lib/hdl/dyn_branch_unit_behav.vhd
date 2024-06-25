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
        variable new_rix, rix_int, pc_raw: word_T;
    begin
        pc_raw := (word_T'high-1 downto 1 => pc.ix(word_T'high-1 downto 1), others => '0');
        new_rix := std_logic_vector(unsigned(pc_raw) + 4);
        rix_int :=  (word_T'high-1 downto 1 => new_rix(word_T'high-1 downto 1), 0 => '1', others => '0') when pc.ix(0) = '0' else
                    (word_T'high-1 downto 1 => new_rix(word_T'high-1 downto 1), others => '0') when pc.ix(0) = '1';
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
                ra_out <=   (tag => POINTER, data => rptr.val, pi => rix_int, delta => rptr.dt) when rdst_ix = ali_T'pos(ra) else
                            (tag => DATA, data => rix_int, pi => (others => '0'), delta => (others => '0'));
                state_error <=  (raux.val(0) = rptr.pi(0) and rdst_ix = ali_T'pos(ra)) or (raux.val(0) /= rptr.pi(0) and rdat.ali = ra);
            when jal =>
                dbt_valid <= false;
                ra_out <= (tag => POINTER, data => rptr.val, pi => rix_int, delta => rptr.dt);
                state_error <= raux.val(0) = rdat.val(0) and rdst_ix = ali_T'pos(ra);
            when jlib =>
                dbt_valid <= true;
                rix_int(31) := '1';
                ra_out <= (tag => POINTER, data => pc.ptr, pi => rix_int, delta => pc.dt);
                state_error <= raux.val(0) = rdat.val(0);
            when others => 
                dbt_valid <= false;
        end case;
    end process;

    dbt.ix <=   '0' & rptr.pi(word_T'high-1 downto 1) & '0' when rdat.ali = ra and branch_mode = jalr  else
                rdat.val(word_T'high downto 1) & '0' when branch_mode = jalr else
                std_logic_vector(unsigned(imm)) when branch_mode = jlib else
                std_logic_vector(to_unsigned(to_integer(unsigned(pc.ix)) + to_integer(signed(imm)), WORD_SIZE));
    dbt.ptr <=  rptr.val when (branch_mode = jalr and rdat.ali = ra and rptr.pi(31) = '1') or branch_mode = jlib else pc.ptr;
    dbt.pi <=   pc.pi;
    dbt.dt <=   pc.dt;
END ARCHITECTURE behav;

