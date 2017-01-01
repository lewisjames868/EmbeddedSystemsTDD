
arm-none-eabi-gcc -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -I. -DSTM32F10X_CL -c core_cm3.c -o core_cm3.o
arm-none-eabi-gcc -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -I. -DSTM32F10X_CL -Os -c main.c -o main.o
arm-none-eabi-gcc -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -I. -DSTM32F10X_CL -Os -c system_stm32f10x.c -o system_stm32f10x.o
arm-none-eabi-gcc -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -I. -DSTM32F10X_CL -c startup_stm32f10x_cl.s -o startup_stm32f10x_cl.o
arm-none-eabi-gcc -mcpu=cortex-m3 -mlittle-endian -mthumb -DSTM32F10X_CL -Tstm32_flash.ld -Wl,--gc-sections *.o -o main.elf
arm-none-eabi-objcopy -Oihex main.elf main.hex
