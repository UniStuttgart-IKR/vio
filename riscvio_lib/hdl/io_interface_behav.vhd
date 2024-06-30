--
-- VHDL Architecture riscvio_lib.io_interface.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:32:44 29.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF io_interface IS
    signal io_access: boolean;
BEGIN
    io_access <= ptr.data(TAG_RANGE) = IO_POINTER_TAG;
    stall <= '1' when io_stall = '1' else 'Z';
    ld <= io_rdata when io_access else (others => '0');
    io_mode <= mode when io_access else holiday;
    io_ix <= addr;
    io_dev <= ptr.data(31 downto 20);
    io_wdata <= (others => '0') when not io_access else
                sd_rdat.val when mode = store_rpc else
                sd_raux.val;
                
                 
END ARCHITECTURE behav;

