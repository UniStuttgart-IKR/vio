--
-- VHDL Entity riscvio_lib.io_interface.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:32:27 29.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;


ENTITY io_interface IS
    PORT(
        addr:       in word_T;
        next_addr:  in word_T;

        sd_rdat:    in rdat_T;
        sd_rptr:    in rptr_T;
        sd_raux:    in raux_T;

        ena:        in boolean;

        mode:       in mem_mode_T;
        next_mode:  in mem_mode_T;

        ld:         out word_T;
        stall:      out std_logic;


        io_wdata:   out word_T;
        io_rdata:   in word_T;
        io_addr:    out word_T;
        io_wreq:    out boolean;
        io_rreq:    out boolean;
        io_stall:   in std_logic


    );
END ENTITY io_interface;

