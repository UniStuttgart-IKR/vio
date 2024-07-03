
library ieee;
use ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.isa.all;

ARCHITECTURE behav OF obj_init_fsm IS

    signal obj_init_addr_int: word_T;
    signal unit_active: boolean;
    signal unit_activating: boolean;

    signal heap_alc: boolean;
    signal obj_init_stall: boolean;

    signal end_addr_aligned, start_addr_aligned: word_T;
BEGIN
    unit_active     <= pgu_mode_ex = pgu_alc or pgu_mode_ex = pgu_alcp or pgu_mode_ex = pgu_alcd or pgu_mode_ex = pgu_alci or pgu_mode_ex = pgu_push or pgu_mode_ex = pgu_pusht or pgu_mode_ex = pgu_pushg;
    unit_activating <= pgu_mode_dc_uq = pgu_alc or pgu_mode_dc_uq = pgu_alcp or pgu_mode_dc_uq = pgu_alcd or pgu_mode_dc_uq = pgu_alci or pgu_mode_dc_uq = pgu_push or pgu_mode_dc_uq = pgu_pusht or pgu_mode_dc_uq = pgu_pushg;
    end_addr_aligned <= (end_addr(word_T'high downto 3) & "000");
    start_addr_aligned <= res_ex_uq.val(word_T'high downto 3) & "000" when unit_activating else
                          res_ex.val(word_T'high downto 3) & "000" when unit_active else
                          (others => '0');

    heap_alc <= (pgu_mode_ex = pgu_alc or  pgu_mode_ex = pgu_alcp or  pgu_mode_ex = pgu_alcd or  pgu_mode_ex = pgu_alci) and rdst_ix_ex /= ali_T'pos(frame);
    
    init: process(clk, res_n) is
    begin
        if res_n = '0' then
            obj_init_addr_int <= (others => '0');
        elsif clk'event and clk = '1' then
            if unit_activating then
                obj_init_addr_int <= start_addr_aligned;
            elsif not unit_active then
                obj_init_addr_int <= (others => '0');
            elsif not dc_stall and obj_init_stall and unit_active then
                obj_init_addr_int <= word_T(unsigned(obj_init_addr_int) + 8);
            end if;
        end if;
    end process init;
    obj_init_addr <= start_addr_aligned when unit_activating else obj_init_addr_int when unit_active else (others => '0');
    next_obj_init_addr <= word_T(unsigned(obj_init_addr) + 8);
    obj_init_data <= res_ex.dt & res_ex.pi when obj_init_addr = start_addr_aligned and unit_active else
                     res_ex_uq.dt & res_ex_uq.pi when obj_init_addr = start_addr_aligned and unit_activating else
                     (others => '0');
    obj_init_stall <= unit_active and unsigned(obj_init_addr_int) < unsigned(end_addr_aligned);
    stall <= '1' when obj_init_stall else 'Z';
    obj_init_wr <= (unit_active and unsigned(obj_init_addr_int) < unsigned(end_addr_aligned)) or unit_activating;

    
END ARCHITECTURE behav;

