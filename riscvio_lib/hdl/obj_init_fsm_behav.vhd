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
    unit_active <= ctrl_ex.pgu_mode = pgu_alc or ctrl_ex.pgu_mode = pgu_alcp or ctrl_ex.pgu_mode = pgu_alcd or ctrl_ex.pgu_mode = pgu_alci or ctrl_ex.pgu_mode = pgu_push or ctrl_ex.pgu_mode = pgu_pusht or ctrl_ex.pgu_mode = pgu_pushg;


    pi <= (4 downto 0 => imm_ex(4 downto 0), others => '0') when ctrl_ex.pgu_mode = pgu_alci or ctrl_ex.pgu_mode = pgu_push or ctrl_ex.pgu_mode = pgu_pusht or ctrl_ex.pgu_mode = pgu_pushg  else 
          rdat_ex.val when ctrl_ex.pgu_mode = pgu_alc or ctrl_ex.pgu_mode = pgu_alcd else
          imm_ex when ctrl_ex.pgu_mode = pgu_alcp else
          (others => '0');
    dt <= (6 downto 0 => imm_ex(11 downto 5), others => '0') when ctrl_ex.pgu_mode = pgu_alci or ctrl_ex.pgu_mode = pgu_push or ctrl_ex.pgu_mode = pgu_pusht or ctrl_ex.pgu_mode = pgu_pushg  else 
          raux_ex.val when ctrl_ex.pgu_mode = pgu_alc else
          rdat_ex.val when ctrl_ex.pgu_mode = pgu_alcp else
          imm_ex when ctrl_ex.pgu_mode = pgu_alcd else
          (others => '0');

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
                            clr_addr_int <= word_T(unsigned(alu_out_ex) + 4);
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
        obj_init_addr <= clr_addr_int when current_state = WRITING else word_T(unsigned(alu_out_ex));
        obj_init_data <= dt when clr_addr_int = word_T(unsigned(alu_out_ex) + 4) and current_state = WRITING else
                        (others => '0') when current_state = WRITING else 
                         pi;
                    
                    

    end process;
END ARCHITECTURE behav;

