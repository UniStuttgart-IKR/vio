SRCDIR	= src
BINDIR	= bin
OUTDIR	= out
MISCDIR	= misc

# %:
# 	@riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -mno-save-restore -mstrict-align -c $(SRCDIR)/$@.s
# 	@mv $@.o $(BINDIR)/
# 	@riscv64-unknown-elf-gcc -nostartfiles -g -nostdlib -T $(MISCDIR)/riscv_model.ld -o $(BINDIR)/$@ $(BINDIR)/$@.o
# 	@riscv64-unknown-elf-objcopy -O binary --only-section=.text $(BINDIR)/$@ $(BINDIR)/$@_comp
# 	@riscv64-unknown-elf-objdump -d -M no-aliases $(BINDIR)/$@.o > $(OUTDIR)/$@.txt



%.o: $(SRCDIR)/%.s
	@$(MISCDIR)/bin/riscv32-unknown-elf-as $^ -march=rv32i_zbb_zor_zri -o $(BINDIR)/$@
	
%.s: $(SRCDIR)/%.S
	python3 $(MISCDIR)/riscvio-preproc.py $^
	@sleep 0.1

%.bin: $(BINDIR)/%.o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -e _start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^
	@$(MISCDIR)/bin/riscv32-unknown-elf-objcopy -O binary --remove-section .riscv.attributes $(OUTDIR)/$@ $(OUTDIR)/$(basename $@).bin
	
%.elf: $(BINDIR)/%.o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -nostdlib -e _start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^
#	@riscv64-unknown-elf-gcc -r -nostartfiles -nostdlib -e _start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^

%.l: $(OUTDIR)/%.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-objdump -D -M no-aliases $^ > $(basename $^).l

%.l: $(OUTDIR)/%.bin
	@$(MISCDIR)/bin/riscv32-unknown-elf-objdump -D -M no-aliases $^ > $(basename $^).l

%.txt: $(OUTDIR)/%.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-readelf -a $^ > $(basename $^).txt

%.hex: $(OUTDIR)/%.bin
	@hexdump -C -v $(basename $^).bin > $(basename $^).hex

%.hex: $(OUTDIR)/%.elf
	@hexdump -C -v $(basename $^).elf > $(basename $^).hex

%.dat: $(OUTDIR)/%.bin
	@hexdump -C -v $(basename $^).bin | cut -c 11-58  | tr -d ' ' | paste -d '' - - > $(basename $^).dat

%.dat: $(OUTDIR)/%.elf
	@hexdump -C -v $(basename $^).elf | cut -c 10-58  | tr -d "\n\r" | tr -d ' ' | sed 's/.\{2\}/& ,0x/g' | head -n 64 > $(basename $^).dat

%.mif: $(SRCDIR)/%.s
	@$(MISCDIR)/bin/riscv32-unknown-elf-as $^ -march=rv32i_zbb_zor_zri -o $(BINDIR)/$(basename $@).o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -e _start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $(BINDIR)/$(basename $@).o
	@$(MISCDIR)/bin/riscv32-unknown-elf-objcopy -O binary --remove-section .riscv.attributes $(OUTDIR)/$@ $(OUTDIR)/$(basename $@).bint
	@python3 misc/dat2mif.py -d 256 -w 32 -p 00000000  $(OUTDIR)/$(basename $@).bint $(OUTDIR)/$(basename $@).mif
	@rm $(OUTDIR)/*.bint

%.mif: $(BINDIR)/%.o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -e _start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^
	@$(MISCDIR)/bin/riscv32-unknown-elf-objcopy -O binary --remove-section .riscv.attributes $(OUTDIR)/$@ $(OUTDIR)/$(basename $@).bint
	@python3 misc/dat2mif.py -d 256 -w 32 -p 00000000  $(OUTDIR)/$(basename $@).bint $(OUTDIR)/$(basename $@).mif

lauflicht: $(BINDIR)/lauflicht.o

clean:
	@rm $(BINDIR)/* $(OUTDIR)/*