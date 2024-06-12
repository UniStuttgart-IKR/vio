--
-- VHDL Architecture riscvio_lib.dcbr_wraccess_mux.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc038)
--          at - 17:03:13 06/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF dcbr_wraccess_mux IS
BEGIN
    ram_byteena_me <= (others => '1') when clr_wr else dram_byteena_a;
    ram_addr_me <= clr_addr(ram_addr_me'high + 2 downto 2) when clr_wr else dram_address_a(ram_addr_me'high + 2 downto 2);
    ram_wren_me <= '1' when clr_wr else dram_wren_a;
    ram_wdata_me <= clr_data when clr_wr else dram_data_a;

END ARCHITECTURE behav;

