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
    data_ram_byteena_a <= (others => '1') when clr_wr else dram_byteena_a;
    data_ram_address_a <= clr_addr(data_ram_address_a'high + 2 downto 2) when clr_wr else dram_address_a(data_ram_address_a'high + 2 downto 2);
    data_ram_wren_a <= '1' when clr_wr else dram_wren_a;
    data_ram_data_a <= X"11111111" when clr_wr else dram_data_a;

END ARCHITECTURE behav;

