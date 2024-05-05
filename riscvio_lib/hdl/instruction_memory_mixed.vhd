--
-- VHDL Architecture riscvio_lib.instruction_memory.mixed
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:39:04 05.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY riscvio_lib;
USE riscvio_lib.FPGA_compatible_block_ram;

ARCHITECTURE mixed OF instruction_memory IS
    constant LOG_SIZE_WORDS: natural := 8;
    constant SIZE_WORDS: natural := 2 ** LOG_SIZE_WORDS;
    signal bram_addr: std_logic_vector(LOG_SIZE_WORDS - 1 downto 0);
BEGIN

  bram_addr <= addr(LOG_SIZE_WORDS + 1 downto 2) when to_integer(unsigned(addr)) < SIZE_WORDS else (others=>'0');
  
  addrcheck: process(clk) is
  BEGIN
    if clk'event and clk = '1' then
      assert to_integer(unsigned(addr)) / (WORD_SIZE / BYTE_SIZE) < SIZE_WORDS report "instruction address out of range!" severity failure;
    end if;
  end process addrcheck;

  stall <= false;
  bram : entity FPGA_compatible_block_ram
    generic map(
      ADDRW => LOG_SIZE_WORDS,
      DATAW => word_T'length,
      DATADEPTH => SIZE_WORDS,
      INITIALCONTENTFILE => "instructions.mif"
    )
    port map(
      clock => clk,
      address => bram_addr,
      q => instr
      
    );
END ARCHITECTURE mixed;

