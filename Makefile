
%.elf: src/%.S
	riscv64-unknown-elf-gcc -nostdlib -nostartfiles -march=rv32i -mabi=ilp32 link.ld $< -o build/$@

%.bin: %.elf
	objcopy -O binary build/$< build/$@

build: $(example).bin

# Installs the bitstream in the fpga
program: $(example).bin
	openocd -f openocd.cfg -c "program build/$(example).bin verify 0x20000000 reset exit"

clean:
	rm -fr build/*.elf build/*.bin

