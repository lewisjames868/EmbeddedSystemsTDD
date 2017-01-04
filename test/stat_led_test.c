#include "unity.h"
#include "stat_led.h"

uint32_t APB2ENR = 0x0;
uint32_t CRL = 0x0;
uint32_t ODL = 0x0;

void setup(void) 
{
	_vStatLedSetState(&APB2ENR, &CRL, &ODL);
	vStatLedInit();
}

void tearDown(void)
{
	_vStatLedResetState();
}

void test_afterInitLedStateOff(void)
{
	setup();
	TEST_ASSERT_FALSE(ucStatLedState());
	tearDown();
}

void test_afterInitTurnOnLedStateOn(void)
{
	setup();
	vStatLedOn();
	TEST_ASSERT_TRUE(ucStatLedState());
	tearDown();
}

int main(void)
{
	UNITY_BEGIN();
	RUN_TEST(test_afterInitLedStateOff);
	RUN_TEST(test_afterInitTurnOnLedStateOn);
	return UNITY_END();
}
