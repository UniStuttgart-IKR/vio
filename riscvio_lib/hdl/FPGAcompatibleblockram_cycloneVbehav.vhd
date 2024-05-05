--
-- VHDL Architecture NESSoundEmu_lib.FPGA_compatible_block_ram.cycloneVbehav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:54:50 06.04.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ARCHITECTURE cycloneVbehav OF FPGA_compatible_block_ram IS
  SIGNAL sub_wire0	: STD_LOGIC_VECTOR (data'range);
  signal stdlogaddr : STD_LOGIC_VECTOR (address'range);
  signal wren: std_logic;
BEGIN
	q  <= sub_wire0 when oe else (others => 'Z');
	wren <= '1' when we else '0';

	altsyncram_component : altsyncram
	GENERIC MAP (
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => INITIALCONTENTFILE,
		intended_device_family => "Cyclone V",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => DATADEPTH,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE",
		read_during_write_mode_port_a => "NEW_DATA_NO_NBE_READ",
		widthad_a => address'length,
		width_a => data'length,
		width_byteena_a => 1
	)
	PORT MAP (
		address_a => address,
		clock0 => clock,
		data_a => data,
		wren_a => wren,
		q_a => sub_wire0
	);

END ARCHITECTURE cycloneVbehav;

