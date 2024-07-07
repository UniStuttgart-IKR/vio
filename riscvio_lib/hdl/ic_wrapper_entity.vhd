--
-- VHDL Entity riscvio_lib.ic_wrapper.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:41:12 23.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.isa.all;


ENTITY ic_wrapper IS
	PORT
	(
		pc		   : IN pc_T;
        next_pc    : IN pc_T;
		clk        : IN STD_LOGIC  := '1';
        res_n      : IN std_logic;
		instr      : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        stall      : OUT boolean;

        sbranch    : IN boolean;
        dbranch    : IN boolean;
        pipe_flush : IN boolean;

        ic_rreq            : OUT boolean;
        ic_rack            : IN boolean;
        ic_raddr           : OUT std_logic_vector(ADDR_WIDTH - 1 downto 0);
        ic_rdata           : IN std_logic_vector(BUS_WIDTH - 1 downto 0)
	);
END ic_wrapper;

