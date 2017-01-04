#include <stdint.h>

/* For testing only */
void _vStatLedSetState(volatile uint32_t * APB2ENR, volatile uint32_t * CRL, volatile uint32_t * BSRR);
void _vStatLedResetState();

/* Real API */
void vStatLedInit(void);
void vStatLedOn(void);
void vStatLedOff(void);
unsigned char ucStatLedState(void);
