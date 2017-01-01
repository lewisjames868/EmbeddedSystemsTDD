#include <stm32f10x.h>
 
#define LED_PIN 6
#define LED_ON() GPIOC->BSRR = (1 << LED_PIN)
#define LED_OFF() GPIOC->BRR = (1 << LED_PIN)
 
void delay(uint32_t d) {
    volatile uint32_t c = d;
    for(; c>0; c--) {
    }
}

int main() {
	/* Enable PORT C clock */
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
	/* Configure GPIOC pin as general purpose push-pull */
	GPIOC->CRL &= ~(GPIO_CRL_CNF6_0 | GPIO_CRL_CNF6_1);
	/* Configure GPIOC pin as output, 50MHz */
	GPIOC->CRL |= (GPIO_CRL_MODE6_0 | GPIO_CRL_MODE6_1);
 



	while(1) {
		/* Turn on the LED */
		LED_ON();

		delay(1000000);

		LED_OFF();

		delay(1000000);
	}

	return 0;
}
