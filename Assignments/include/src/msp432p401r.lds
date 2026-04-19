/******************************************************************************
 * Copyright (C) 2017 by Alex Fosdick - University of Colorado
 *
 * Redistribution, modification or use of this software in source or binary
 * forms is permitted as long as the files maintain this copyright. Users are 
 * permitted to modify this and use it to learn about the field of embedded
 * software. Alex Fosdick and the University of Colorado are not liable for any
 * misuse of this material. 
 *
 *****************************************************************************/
/**
 * @file msp432p401r.lds
 * @brief Linker script for MSP432P401R microcontroller
 *
 * This linker script defines the memory layout and sections for the
 * MSP432P401R ARM Cortex-M4F microcontroller.
 *
 * @author Alex Fosdick
 * @date April 1 2017
 *
 */

MEMORY
{
    FLASH_TEXT (RX) : ORIGIN = 0x00000000, LENGTH = 0x0003FFFF
    SRAM_DATA (RWX) : ORIGIN = 0x20000000, LENGTH = 0x0000FFFF
}

SECTIONS
{
    .text :
    {
        KEEP(*(.vectors))
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
    } > FLASH_TEXT

    .data :
    {
        *(.data)
        *(.data*)
    } > SRAM_DATA AT > FLASH_TEXT

    .bss :
    {
        *(.bss)
        *(.bss*)
        *(COMMON)
    } > SRAM_DATA
    
    _etext = LOADADDR(.data) + SIZEOF(.data);
    _data = ADDR(.data);
    _edata = ADDR(.data) + SIZEOF(.data);
    _bss_start = ADDR(.bss);
    _bss_end = ADDR(.bss) + SIZEOF(.bss);
}
