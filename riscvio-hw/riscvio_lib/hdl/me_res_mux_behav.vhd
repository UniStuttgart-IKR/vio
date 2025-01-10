--
-- VHDL Architecture riscvio_lib.me_res_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:00:37 16.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF me_res_mux IS
    signal in_data: std_logic_vector(mem_out_me_u'range);
BEGIN
    in_data <= mem_out_me_u when rptr_ex.val(TAG_RANGE) /= IO_POINTER_TAG else X"00000000" & io_out_me_u; 
    res_me_u <= (val => in_data(WORD0_RANGE), tag => DATA,    ix => (others => '0'),      pi => (others => '0'), dt => (others => '0')) when ctrl_ex.me_mode /= holiday and ctrl_ex.me_mode /= lp and ctrl_ex.me_mode /= load_ix and ctrl_ex.me_mode /= load_rpc else
                (val => in_data(WORD0_RANGE), tag => POINTER, ix => (others => '0'),      pi => (others => '0'), dt => (others => '0')) when ctrl_ex.me_mode = lp else
                (val => res_ex.val,           tag => POINTER, ix => in_data(WORD0_RANGE), pi => res_ex.pi,       dt => res_ex.dt)       when ctrl_ex.me_mode = load_rpc and rptr_ex.dt(31 downto 30) /= "10" else
                (val => in_data(WORD1_RANGE), tag => POINTER, ix => in_data(WORD0_RANGE), pi => (others => '0'), dt => (others => '0')) when ctrl_ex.me_mode = load_rpc else
                (val => raux_ex.val,          tag => POINTER, ix => in_data(WORD0_RANGE), pi => (others => '0'), dt => (others => '0')) when ctrl_ex.me_mode = load_ix else
                res_ex;
END ARCHITECTURE behav;