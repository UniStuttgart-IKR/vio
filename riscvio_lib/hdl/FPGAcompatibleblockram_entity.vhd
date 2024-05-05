--
-- VHDL Entity NESSoundEmu_lib.FPGA_compatible_block_ram.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:52:59 06.04.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FPGA_compatible_block_ram IS
  generic(
    ADDRW : positive;
    DATAW : positive;
    DATADEPTH : positive;
    INITIALCONTENTFILE : string
  );
  PORT
	(
		address		: IN std_logic_vector(ADDRW - 1 downto 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (DATAW- 1 downto 0) := (others => '0');
		we		: IN boolean := false;
		oe  : IN boolean := true;
		q   : OUT STD_LOGIC_VECTOR (DATAW- 1 downto 0)
	);
END ENTITY FPGA_compatible_block_ram;

