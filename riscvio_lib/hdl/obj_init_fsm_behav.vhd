
library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
library riscvio_lib;
use riscvio_lib.isa.all;

ARCHITECTURE behav OF obj_init_fsm IS

    signal obj_init_addr_int: word_T;
    signal unit_active: boolean;
    signal unit_activating: boolean;

    signal end_addr_aligned, start_addr_aligned: word_T;
    constant TOP: natural := integer(ceil(log2(real(BUS_WIDTH/8))))-1;
BEGIN
    unit_active     <= pgu_mode_ex = pgu_alc or pgu_mode_ex = pgu_alcp or pgu_mode_ex = pgu_alcd or pgu_mode_ex = pgu_alci or pgu_mode_ex = pgu_push or pgu_mode_ex = pgu_pusht or pgu_mode_ex = pgu_pushg;
    unit_activating <= pgu_mode_dc_uq = pgu_alc or pgu_mode_dc_uq = pgu_alcp or pgu_mode_dc_uq = pgu_alcd or pgu_mode_dc_uq = pgu_alci or pgu_mode_dc_uq = pgu_push or pgu_mode_dc_uq = pgu_pusht or pgu_mode_dc_uq = pgu_pushg;
    end_addr_aligned <= (end_addr(word_T'high downto 3) & "000");
    start_addr_aligned <= word_T(unsigned(res_ex_uq.val(word_T'high downto 3) & "000") + 8) when unit_activating else
                          word_T(unsigned(res_ex.val(word_T'high downto 3) & "000") + 8) when unit_active else
                          (others => '0');
    
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
                obj_init_addr_int <= word_T(unsigned(obj_init_addr_int) + BUS_WIDTH/8);
            end if;

        end if;
    end process init;

    process(obj_init_addr_int, next_obj_init_addr, start_addr_aligned, end_addr_aligned, unit_active, unit_activating) is
        variable SIX: natural range BUS_WIDTH/8-1 downto 0;
        variable EIX: natural range BUS_WIDTH/8-1 downto 0;
    begin
        obj_init_addr <= (others => '0');
        if unit_activating then
            obj_init_addr(word_T'high downto TOP+1) <= start_addr_aligned(word_T'high downto TOP+1);
        elsif unit_active then
            obj_init_addr(word_T'high downto TOP+1) <= obj_init_addr_int(word_T'high downto TOP+1);
        end if;
        if obj_init_addr_int = start_addr_aligned then
            SIX := to_integer(unsigned(obj_init_addr_int(TOP downto 0)));
        else
            SIX := 0;
        end if;
        if unsigned(next_obj_init_addr) > unsigned(end_addr_aligned) then
            EIX := BUS_WIDTH/8-1-to_integer(unsigned(end_addr_aligned(TOP downto 0)));
        else
            EIX := BUS_WIDTH/8-1;
        end if;
        obj_init_byte_ena <= (others => '0');
        obj_init_byte_ena(EIX downto SIX) <= (others => '1');
    end process;

    next_obj_init_addr <= word_T(unsigned(obj_init_addr) + BUS_WIDTH/8);
    obj_init_data <= (others => '0');
    obj_init_stall <= unit_active and unsigned(obj_init_addr_int) < unsigned(end_addr_aligned);
    obj_init_wr <= unit_active and unsigned(obj_init_addr_int) < unsigned(end_addr_aligned);

    
END ARCHITECTURE behav;

