--
-- VHDL Architecture riscvio_lib.alu_a_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:58:53 23.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF alu_a_mux IS
BEGIN
    a <= rdat_dc.val                        when alu_a_in_sel = DAT else
         rptr_dc.val                        when alu_a_in_sel = PTRVAL else
         rptr_dc.pi                         when alu_a_in_sel = PTRPIR else
         "000"   &  rptr_dc.pi(30 downto 2) when alu_a_in_sel = PTRPI  else
         --#TODO: delta is larger for normal objects
         rptr_dc.dt                         when alu_a_in_sel = PTRDTR else
         "00"    &  rptr_dc.dt(29 downto 0) when alu_a_in_sel = PTRDTB else
         "000"   &  rptr_dc.dt(29 downto 1) when alu_a_in_sel = PTRDTH else
         "0000"  &  rptr_dc.dt(29 downto 2) when alu_a_in_sel = PTRDTW else
         "00000" &  rptr_dc.dt(29 downto 3) when alu_a_in_sel = PTRDTD else
            
         raux_dc.ix                         when alu_a_in_sel = AUX and raux_dc.tag = POINTER else
         raux_dc.val;
END ARCHITECTURE behav;


