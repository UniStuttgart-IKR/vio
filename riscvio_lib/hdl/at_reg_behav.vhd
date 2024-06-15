--
-- VHDL Architecture riscvio_lib.at_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 14:01:21 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF at_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            rd_wb <= REG_WB_NULL;
        else
            if clk'event and clk = '1' then
                if not obj_init_stall then
                    rd_wb.rf_index <= rdst_ix_me;
                    rd_wb.csr_index <= ali_T'pos(alc_addr) when (ctrl_me.pgu_mode = pgu_alc 
                                                            or ctrl_me.pgu_mode = pgu_alcp 
                                                            or ctrl_me.pgu_mode = pgu_alcd 
                                                            or ctrl_me.pgu_mode = pgu_alci)
                                                            and rdst_ix_me /= ali_T'pos(frame) else ali_T'pos(no_csr);
                    rd_wb.ali <= ali_T'val(rdst_ix_me);
                    rd_wb.mem.data <= alu_out_me when ctrl_me.me_mode = holiday and ctrl_me.at_mode = no else mem_out_me;
                                      
                    rd_wb.mem.pi <= (4 downto 0 => imm_me(4 downto 0), others => '0') when ctrl_me.pgu_mode = pgu_alci or ctrl_me.pgu_mode = pgu_push or ctrl_me.pgu_mode = pgu_pusht or ctrl_me.pgu_mode = pgu_pushg  else 
                                    rdat_me.val when ctrl_me.pgu_mode = pgu_alc or ctrl_me.pgu_mode = pgu_alcd else
                                    imm_me when ctrl_me.pgu_mode = pgu_alcp else
                                    pi_at_u when ctrl_me.at_mode = yes else
                                    (others => '0');
                    rd_wb.mem.delta <= (6 downto 0 => imm_me(11 downto 5), others => '0') when ctrl_me.pgu_mode = pgu_alci or ctrl_me.pgu_mode = pgu_push or ctrl_me.pgu_mode = pgu_pusht or ctrl_me.pgu_mode = pgu_pushg  else 
                                        raux_me.val when ctrl_me.pgu_mode = pgu_alc else
                                        rdat_me.val when ctrl_me.pgu_mode = pgu_alcp else
                                        imm_me when ctrl_me.pgu_mode = pgu_alcd else
                                        dt_at_u when ctrl_me.at_mode = yes else
                                        (others => '0');
                    rd_wb.mem.tag <= POINTER when ctrl_me.pgu_mode = pgu_alci or ctrl_me.pgu_mode = pgu_alcd or ctrl_me.pgu_mode = pgu_alcp or ctrl_me.pgu_mode = pgu_alc or ctrl_me.pgu_mode = pgu_push or ctrl_me.pgu_mode = pgu_pusht or ctrl_me.pgu_mode = pgu_pushg or ctrl_me.me_mode = lp else DATA; --TODO: Robin muss noch me modes einfügen!!!!!
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

