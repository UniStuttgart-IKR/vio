--
-- VHDL Architecture riscvio_lib.obj_init_fsm.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:41:57 15.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
library ieee;
use ieee.numeric_std.all;

ARCHITECTURE behav OF obj_init_fsm IS
    type state_T is (IDLE, WRITING, NEXT_INSTR);
    signal current_state: state_T;

    signal clr_addr_int: word_T;
    signal obj_init_wr_int: boolean;
    signal unit_active: boolean;
    signal last_rptr_ex: rptr_T;

    signal pi: word_T;
    signal dt: word_T;
BEGIN
    unit_active <= pgu_mode_ex = pgu_alc or pgu_mode_ex = pgu_alcp or pgu_mode_ex = pgu_alcd or pgu_mode_ex = pgu_alci or pgu_mode_ex = pgu_push or pgu_mode_ex = pgu_pusht or pgu_mode_ex = pgu_pushg;


    fsm_transistions: process(clk, res_n) is
    begin
        if res_n = '0' then
            current_state <= IDLE;
            clr_addr_int <= (others => '0');
        else
            if clk'event and clk = '1' then
                case current_state is
                    when IDLE => 
                        if unit_active then
                            current_state <= WRITING;
                            clr_addr_int <= word_T(unsigned(res_ex.data) + 4);
                        end if;

                    when WRITING => 
                        if clr_addr_int = end_addr then
                            current_state <= NEXT_INSTR;
                        else
                            clr_addr_int <= std_logic_vector(unsigned(clr_addr_int) + 4);
                        end if;
                    when NEXT_INSTR => 
                        current_state <= IDLE;
                end case;
            end if;
        end if;
    end process fsm_transistions;
    
    process(all) is
    begin
        obj_init_wr_int <= (current_state = WRITING and clr_addr_int /= end_addr) or (unit_active and current_state = IDLE);
        obj_init_stall <= obj_init_wr_int;
        obj_init_wr <= obj_init_wr_int;
        obj_init_addr <= clr_addr_int when current_state = WRITING else word_T(unsigned(res_ex.data));
        obj_init_data <= res_ex.delta when clr_addr_int = word_T(unsigned(res_ex.data) + 4) and current_state = WRITING else
                        (others => '0') when current_state = WRITING else 
                         res_ex.pi;
                    
                    

    end process;
END ARCHITECTURE behav;

