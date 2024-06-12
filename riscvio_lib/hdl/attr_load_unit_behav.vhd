--
-- VHDL Architecture riscvio_lib.attr_load_unit.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 17:39:41 06/12/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF attr_load_unit IS
BEGIN
    ram_addr_at <= mem_out_me_uq(ram_addr_at'high + 3 downto 3);

    pi_at_u <= ram_rdata_at(31 downto 0) when at_mode_me = yes else (others => '0');
    dt_at_u <= ram_rdata_at(63 downto 32) when at_mode_me = yes else (others => '0');
END ARCHITECTURE behav;

