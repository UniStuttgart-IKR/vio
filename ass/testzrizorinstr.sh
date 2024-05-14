/opt/riscv_custom/bin/riscv64-unknown-elf-as  zrizortst.s -o zrizortst.o -march=rv32i
/opt/riscv_custom/bin/riscv64-unknown-elf-ld zrizortst.o -o zrizortst -oformat=hexadecimal
