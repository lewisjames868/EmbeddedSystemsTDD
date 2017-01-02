#include "unity.h"
#include "Timer.h"

void test_canGetTime(void)
{
	TEST_ASSERT_TRUE(0);
}

int main(void)
{
	UNITY_BEGIN();
	RUN_TEST(test_canGetTime);
	return UNITY_END();
}
