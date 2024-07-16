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
LIBRARY riscvio_lib;
USE riscvio_lib.helper.all;

ARCHITECTURE behav OF dyn_branch_unit IS
    pure function calcIndex(ix: word_T; imm: word_T) return word_T is
    begin
        return word_T(unsigned('0' & ix(word_T'high-1 downto 1) & '0') + unsigned(imm));
    end function calcIndex;

    signal dbt_int: pc_T;
BEGIN

    -- dbta_valid needs to clear if, dc registers
    process(all) is
        variable new_rix, rix_int, pc_raw: word_T;
    begin
        rix_int := (others => '0');
        pc_raw := (others => '0');
        pc_raw(word_T'high-1 downto 1) := pc.ix(word_T'high-1 downto 1);
        new_rix := std_logic_vector(unsigned(pc_raw) + 4);
        if pc.ix(0) = '1' then
            rix_int(word_T'high-1 downto 1) := new_rix(word_T'high-1 downto 1);
        else
            rix_int(word_T'high-1 downto 1) := new_rix(word_T'high-1 downto 1);
            rix_int(0) := '1';
        end if;
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
                if dbt.ptr /= pc.ptr and rptr.ali /= ra then
                    rix_int(31) := '1';
                else
                    rix_int(31) := '0';
                end if;
                ra_out <=   (tag => POINTER, val => pc.ptr(word_T'high downto 3) & "111", ix => rix_int, pi => (others => '0'), dt => pc.eoc);
            when jal =>
                dbt_valid <= false;
                ra_out <= (tag => POINTER, val => pc.ptr(word_T'high downto 3) & "111", ix => rix_int, pi => (others => '0'), dt => pc.eoc);
            when jlib =>
                dbt_valid <= true;
                rix_int(31) := '1';
                ra_out <= (tag => POINTER, val => pc.ptr(word_T'high downto 3) & "111", ix => rix_int, pi => (others => '0'), dt => pc.eoc);
            when others => 
                dbt_valid <= false;
        end case;
    end process;

    dbu_exc <= tciob when isTargetCodeIndexOutOfBounds(dbt_int.ix, rptr.pi, pc.eoc, branch_mode, dbt_int.ptr /= pc.ptr and rptr.ali /= ra) and branch_mode = jal else
               tciob when isTargetCodeIndexOutOfBounds(dbt_int.ix, rptr.pi, rptr.dt, branch_mode, dbt_int.ptr /= pc.ptr and rptr.ali /= ra) and branch_mode /= jal else
               sterr when isStateErrorException(rdst_ix, rptr, raux, rdat, pc, pgu_nop, branch_mode) else
               well_behaved;

    dbt_int.ptr <=  rptr.val(word_T'high downto 3) & "000" when branch_mode = jalr or branch_mode = jlib else pc.ptr;
    dbt_int.ix <=   calcIndex(rptr.ix, imm) when branch_mode = jalr  else
                    imm when branch_mode = jlib else
                    calcIndex(pc.ix, imm);
    dbt_int.eoc <=  rptr.dt when branch_mode = jlib or branch_mode = jalr else pc.eoc;

    dbt <= dbt_int;
END ARCHITECTURE behav;

