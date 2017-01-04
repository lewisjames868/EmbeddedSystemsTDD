#include "stat_led.h"
#include "stm32f10x.h"
 
#define LED_PIN 6
 
volatile uint32_t * _APB2ENR = 0x0;
volatile uint32_t * _CRL = 0x0;
volatile uint32_t * _ODR = 0x0;

void _vStatLedSetState(volatile uint32_t * APB2ENR, volatile uint32_t * CRL, volatile uint32_t * ODR)
{
	_APB2ENR = APB2ENR;
	_CRL = CRL;
	_ODR = ODR;
}

void _vStatLedResetState(void)
{
	_vStatLedSetState(&(RCC->APB2ENR), &(GPIOC->CRL), &(GPIOC->ODR));
}

void vStatLedInit(void)
{
	/* Enable PORT C clock */
	*_APB2ENR |= RCC_APB2ENR_IOPCEN;
	/* Configure GPIOC pin as general purpose push-pull */
	*_CRL &= ~(GPIO_CRL_CNF6_0 | GPIO_CRL_CNF6_1);
	/* Configure GPIOC pin as output, 50MHz */
	*_CRL |= (GPIO_CRL_MODE6_0 | GPIO_CRL_MODE6_1);
}

void vStatLedOn(void)
{
	*_ODR |= (1 << LED_PIN);
}

void vStatLedOff(void)
{
	*_ODR &= ~(1 << LED_PIN);
}

unsigned char ucStatLedState(void)
{
	return (*_ODR >> LED_PIN) & 0x1;
}
