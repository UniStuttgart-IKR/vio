OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
  RAM_INST (rx): ORIGIN = 0x0, LENGTH = 0x1000
  RAM_DATA (rw): ORIGIN = 0x1000, LENGTH = 0x1000
  RAM_SDSDFDF (rw): ORIGIN = 0x1238, LENGTH = 0x1000
  ROM (rx): ORIGIN = 0x20010000, LENGTH = 0x2000
}

SECTIONS
{
  .init : ALIGN(4)
  {
    *(.init)
	*(.init.*)
  } > ROM  

  .text : ALIGN(4)
  {
    *(.text)
	*(.text.*)
  }> RAM_INST

  .data : ALIGN(4)
  {
    *(.data)
	*(.data.*)
  }> RAM_DATA

  .bss : ALIGN(4)
  {
	*(.bss)
	*(.bss.*)
  }> RAM_DATA

  .test : ALIGN(4)
  {
    *(.test)
	*(.test.*)
  } > RAM_SDSDFDF  

  _end = .;
}
