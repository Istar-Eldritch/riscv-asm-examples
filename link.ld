OUTPUT_ARCH(riscv)


ENTRY(_start)

MEMORY
{

  RAM (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 0x4000
	FLASH (rxai!w) : ORIGIN = 0x20000000, LENGTH = 60K 
}

SECTIONS
{
  .data : { *(.data)  } > FLASH
  .rodata : { *(.rodata)  } > FLASH
}

