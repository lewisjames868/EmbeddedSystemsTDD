# EmbeddedSystemsTDD
Just me experimenting with TDD for Embedded Systems

# Getting started
This project is intended to be run on an Olimex STM32-P107 development board, programmed with a Segger j-link adapter.

To compile and link run ./build.sh

To start the openocd server, run

	openocd -c "interface jlink" stm32f1x.cfg

To connect GDB to the openocd server, run

	arm-none-gnueabi-gdb 
	target remote localhost:3333
	file main.elf
	load
	monitor reset halt
	continue

# Acknowledgments

* Programming ARM Cortex (STM32) under GNU/Linux - http://regalis.com.pl/en/arm-cortex-stm32-gnulinux/ - Patryk Jaworski
