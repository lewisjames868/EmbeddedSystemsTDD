#include <stm32f10x.h>
#include "stat_led.h"
 
void delay(uint32_t d) {
    volatile uint32_t c = d;
    for(; c>0; c--) {
    }
}

int main() {
	vStatLedInit(); 

	while(1) {
		/* Turn on the LED */
		vStatLedOn();

		delay(1000000);

		vStatLedOff();

		delay(1000000);
	}

	return 0;
}
