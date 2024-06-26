
library ieee;
use ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.isa.all;

ARCHITECTURE behav OF obj_init_fsm IS
    type state_T is (IDLE, WRITING, WAITING,  DONE);
    signal current_state: state_T;
    signal last_state: state_T;

    signal clr_addr_int: word_T;
    signal last_obj_init_addr: word_T;
    signal obj_init_wr_int: boolean;
    signal unit_active: boolean;
    signal last_rptr_ex: rptr_T;

    signal heap_alc: boolean;
    signal heap_overflow_int: boolean;
    signal stack_overflow_int: boolean;

    signal end_addr_aligned, start_addr_aligned: word_T;
BEGIN
    unit_active <= pgu_mode_ex = pgu_alc or pgu_mode_ex = pgu_alcp or pgu_mode_ex = pgu_alcd or pgu_mode_ex = pgu_alci or pgu_mode_ex = pgu_push or pgu_mode_ex = pgu_pusht or pgu_mode_ex = pgu_pushg;
    end_addr_aligned <= (end_addr(word_T'high downto 3) & "000");
    start_addr_aligned <= res_ex.data(word_T'high downto 3) & "000";

    heap_alc <= (pgu_mode_ex = pgu_alc or  pgu_mode_ex = pgu_alcp or  pgu_mode_ex = pgu_alcd or  pgu_mode_ex = pgu_alci) and rdst_ix_ex /= ali_T'pos(frame);

    heap_overflow_int <= unit_active and heap_alc and unsigned(frame_lim_csr) > unsigned(end_addr_aligned) and not IGNORE_EXC;
    stack_overflow_int <= unit_active and not heap_alc and unsigned(alc_lim_csr) > unsigned(end_addr_aligned) and not IGNORE_EXC;
    heap_overflow_ex <= heap_overflow_int;
    stack_overflow_ex <= stack_overflow_int;
    
    fsm_transistions: process(clk, res_n) is
    begin
        if res_n = '0' then
            current_state <= IDLE;
            clr_addr_int <= (others => '0');
            last_obj_init_addr <= (others => '0');
            last_state <= IDLE;
        else
            if clk'event and clk = '1' then
                last_state <= current_state;


                case current_state is
                    when IDLE => 
                        if unit_active and not (stack_overflow_int or heap_overflow_int) then
                            current_state <= WRITING;
                            clr_addr_int <= word_T(unsigned(start_addr_aligned) + 4);
                            last_obj_init_addr <= start_addr_aligned;
                        end if;

                    when WRITING => 
                        if not dc_stall then
                            last_obj_init_addr <= clr_addr_int;
                            if clr_addr_int = end_addr_aligned then
                                current_state <= DONE;
                            else
                                clr_addr_int <= std_logic_vector(unsigned(clr_addr_int) + 4);
                            end if;
                        else
                            if clr_addr_int /= std_logic_vector(to_unsigned(0, word_T'length)) and last_state /= WAITING then
                                clr_addr_int <= std_logic_vector(unsigned(clr_addr_int) - 4);
                            end if; 
                            current_state <= WAITING;
                        end if;
                    
                    when  WAITING => 
                        if not dc_stall then
                            if unsigned(obj_init_addr) = unsigned(end_addr_aligned) - 4 then
                                current_state <= DONE;
                            else
                                last_obj_init_addr <= clr_addr_int;
                                current_state <= WRITING;
                                clr_addr_int <= std_logic_vector(unsigned(clr_addr_int) + 4);
                            end if;
                        end if;

                    when DONE =>
                        current_state <= IDLE;
                end case;
            end if;
        end if;
    end process fsm_transistions;
    
    process(all) is
    begin
        obj_init_wr_int <= ((current_state = WRITING or current_state = WAITING) and obj_init_addr /= end_addr_aligned) or (unit_active and current_state = IDLE and not (stack_overflow_int or heap_overflow_int));
        obj_init_stall <= obj_init_wr_int;
        obj_init_wr <= obj_init_wr_int;
        next_obj_init_addr <= clr_addr_int when (current_state = WRITING or current_state = WAITING) and not dc_stall else
                              start_addr_aligned when dc_stall and current_state = IDLE else 
                              last_obj_init_addr when dc_stall else 
                              res_ex.data;
        obj_init_addr <= start_addr_aligned when current_state = IDLE and unit_active else last_obj_init_addr;
        obj_init_data <= res_ex.delta when clr_addr_int = word_T(unsigned(start_addr_aligned) + 4) and current_state = WRITING else
                        (others => '0') when current_state = WRITING else 
                         res_ex.pi;
                    
    end process;
END ARCHITECTURE behav;

