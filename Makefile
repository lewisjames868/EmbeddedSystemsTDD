LINUX_CC = gcc
ARM_CC = arm-none-eabi-gcc
ARM_LD = arm-none-eabi-ld
CC_FLAGS = -Werror -Wpedantic -Wall
ARM_CC_FLAGS = -mcpu=cortex-m3 -mlittle-endian -mthumb
srcs = $(wildcard src/*.c src/*.s)
objs = $(patsubst %.s, %.o, $(patsubst  %.c, %.o, $(srcs)))
deps = $(filter-out %.s, $(srcs:.c=.d))

main.elf: $(objs)
	$(ARM_LD) -Tstm32_flash.ld --gc-sections -nostdlib -nostartfiles -nodefaultlibs $^ -o $@
 
%.o: %.c
	$(ARM_CC) $(CC_FLAGS) $(ARM_CC_FLAGS) -Iinclude -DSTM32F10X_CL -MMD -c $< -o $@

%.o: %.s
	$(ARM_CC) $(CC_FLAGS) $(ARM_CC_FLAGS) -Iinclude -DSTM32F10X_CL -MMD -c $< -o $@

.PHONY: clean

.SUFFIXES:

# $(RM) is rm -f by default
clean:
	$(RM) $(objs) $(deps) main.elf stat_led_test.out

test: stat_led_test.out
	./stat_led_test.out

stat_led_test.out: test/stat_led_test.c test/unity.c src/stat_led.c
	$(LINUX_CC) $(CC_FLAGS) -Itest -Iinclude -DSTM32F10X_CL $^ -o $@

-include $(deps)

program: main.elf poweron
	openocd -c "interface jlink" -f stm32f1x.cfg -c"program $< verify reset exit"

poweron:
	JLinkExe -if JTAG -autoconnect 1 -CommanderScript poweron.jlink	
