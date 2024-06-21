--
-- VHDL Architecture riscvio_lib.attr_load_unit.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:42:29 15.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF attr_load_unit IS
BEGIN
    ram_addr_at <= addr_me_uq.data(ram_addr_at'high + 3 downto 3);

    pi_at_u <= ram_rdata_at(31 downto 0) when at_mode_me = yes else (others => '0');
    dt_at_u <= ram_rdata_at(63 downto 32) when at_mode_me = yes else
               (others => '0');
END ARCHITECTURE behav;

