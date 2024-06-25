SRCDIR	= src
BINDIR	= bin
OUTDIR	= out
MISCDIR	= misc

%.s: $(SRCDIR)/%.s3
	@python3 $(MISCDIR)/riscvio-preproc.py $^
	@sleep 0.1

%.o: $(SRCDIR)/%.s
	@$(MISCDIR)/bin/riscv32-unknown-elf-as $^ -march=rv32i_zbb_zor_zri -o $(BINDIR)/$@
	
%.bin: $(BINDIR)/%.o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -e core.start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^
	@$(MISCDIR)/bin/riscv32-unknown-elf-objcopy -O binary $(OUTDIR)/$@ $(OUTDIR)/$(basename $@).bin
	
%.elf: $(BINDIR)/%.o
	@$(MISCDIR)/bin/riscv32-unknown-elf-ld -nostdlib -e core.start -T $(MISCDIR)/riscv_model.ld -o $(OUTDIR)/$@ $^

%.hex: $(OUTDIR)/%.bin
	@hexdump -C -v $(basename $^).bin > $(basename $^).hex

%.hex: $(OUTDIR)/%.elf
	@hexdump -C -v $(basename $^).elf > $(basename $^).hex

%.dat: $(OUTDIR)/%.bin
	@hexdump -C -v $(basename $^).bin | cut -c 11-58  | tr -d ' ' | paste -d '' - - > $(basename $^).dat

%.dat: $(OUTDIR)/%.elf
	@hexdump -C -v $(basename $^).elf | cut -c 10-58  | tr -d "\n\r" | tr -d ' ' | sed 's/.\{2\}/& ,0x/g' | head -n 64 > $(basename $^).dat

%.mif: %.s %.o %.bin
	@python3 misc/dat2mif.py -d 512 -w 64 -p 0000000000000000  $(OUTDIR)/$(basename $@).bin $(OUTDIR)/$(basename $@).mif

%.mif: %.o %.bin
	@python3 misc/dat2mif.py -d 512 -w 64 -p 0000000000000000  $(OUTDIR)/$(basename $@).bin $(OUTDIR)/$(basename $@).mif

%.l: %.s %.o %.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-objdump -D -M no-aliases $(OUTDIR)/$(basename $@).elf > $(OUTDIR)/$(basename $@).l
	
%.l: %.o %.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-objdump -D -M no-aliases $(OUTDIR)/$(basename $@).elf > $(OUTDIR)/$(basename $@).l

%.txt: %.s %.o %.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-readelf -a $(OUTDIR)/$(basename $@).elf > $(OUTDIR)/$(basename $@).txt

%.txt: %.o %.elf
	@$(MISCDIR)/bin/riscv32-unknown-elf-readelf -a $$(OUTDIR)/$(basename $@).elf > $(OUTDIR)/$(basename $@).txt

clean:
	@rm $(BINDIR)/* $(OUTDIR)/*
