--
-- VHDL Architecture riscvio_lib.clr_ptrs_fsm.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc038)
--          at - 17:17:10 06/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;
ARCHITECTURE behav OF clr_ptrs_fsm IS
    type state_T is (IDLE, CLEARING);
    signal current_state: state_T;

    signal clr_addr_int: word_T;
    signal clr_wr_int: boolean;
    signal start_clearing: boolean;
    signal last_rptr_ex: rptr_T;
BEGIN
    start_clearing <= ctrl_ex.pgu_mode /= pgu_nop and rdst_ix_ex /= ali_T'pos(frame);
    
    rptr_delay: process(clk, res_n) is
    begin
        if res_n = '0' then
            last_rptr_ex <= RPTR_NULL;
        else
            if clk'event and clk = '1' then
                last_rptr_ex <= rptr_ex;
            end if;
        end if;
    end process;

    fsm_transistions: process(clk, res_n) is
    begin
        if res_n = '0' then
            current_state <= IDLE;
            clr_addr_int <= (others => '0');
        else
            if clk'event and clk = '1' then
                case current_state is
                    when IDLE => 
                        if start_clearing then
                            current_state <= CLEARING;
                            clr_addr_int <= word_T(unsigned(alu_out_ex) + 12);
                        end if;

                    when CLEARING => 
                        if clr_addr = last_rptr_ex.val then
                            current_state <= IDLE;
                        else
                            clr_addr_int <= std_logic_vector(unsigned(clr_addr) + 4);
                        end if;
                end case;
            end if;
        end if;
    end process fsm_transistions;

    clr_wr_int <= (current_state = CLEARING and not clr_addr_int = last_rptr_ex.val) or start_clearing;
    clr_stall <= clr_wr_int;
    clr_wr <= clr_wr_int;
    clr_addr <= clr_addr_int when current_state = CLEARING else word_T(unsigned(alu_out_ex) + 8);
    clr_pgu_mode_me <= current_state = CLEARING and clr_addr_int = last_rptr_ex.val;
END ARCHITECTURE behav;

