LINUX_CC = gcc
ARM_CC = arm-none-eabi-gcc
srcs = $(wildcard src/*.c src/*.s)
objs = $(patsubst %.s, %.o, $(patsubst  %.c, %.o, $(srcs)))
deps = $(filter-out %.s, $(srcs:.c=.d))

main.elf: $(objs)
	$(ARM_CC) -mcpu=cortex-m3 -mlittle-endian -mthumb -DSTM32F10X_CL -Tstm32_flash.ld -Wl,--gc-sections $^ -o $@

%.o: %.c
	$(ARM_CC) -Wpedantic -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -Iinclude -DSTM32F10X_CL -MMD -c $< -o $@

%.o: %.s
	$(ARM_CC) -Wpedantic -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -Iinclude -DSTM32F10X_CL -MMD -c $< -o $@

.PHONY: clean

.SUFFIXES:

# $(RM) is rm -f by default
clean:
	$(RM) $(objs) $(deps) main.elf stat_led_test.out

test: stat_led_test.out
	./stat_led_test.out

stat_led_test.out: test/stat_led_test.c test/unity.c src/stat_led.c
	$(LINUX_CC) -Wpedantic -Itest -Iinclude -DSTM32F10X_CL $^ -o $@

-include $(deps)

program: main.elf
	openocd -c "interface jlink" -f stm32f1x.cfg -c"program $< verify reset exit"
