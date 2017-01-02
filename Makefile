LINUX_CC = gcc
ARM_CC = arm-none-eabi-gcc
srcs = $(wildcard src/*.c src/*.s)
objs = $(patsubst %.s, %.o, $(patsubst  %.c, %.o, $(srcs)))
deps = $(filter-out %.s, $(srcs:.c=.d))

main.elf: $(objs)
	$(ARM_CC) -mcpu=cortex-m3 -mlittle-endian -mthumb -DSTM32F10X_CL -Tstm32_flash.ld -Wl,--gc-sections $^ -o $@

%.o: %.c
	$(ARM_CC) -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -Iinclude -DSTM32F10X_CL -MMD -c $^ -o $@

%.o: %.s
	$(ARM_CC) -Wall -mcpu=cortex-m3 -mlittle-endian -mthumb -Iinclude -DSTM32F10X_CL -MMD -c $^ -o $@

.PHONY: clean

.SUFFIXES:

# $(RM) is rm -f by default
clean:
	$(RM) $(objs) $(deps) main.elf

test: TimerTest

TimerTest: test/TimerTest.c test/unity.c
	$(LINUX_CC) -Itest $^ -o $@

-include $(deps)
