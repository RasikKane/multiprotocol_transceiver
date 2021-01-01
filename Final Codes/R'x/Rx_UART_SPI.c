#include <Philips\LPC2148.h>
#include "UART0.h"

#define	VPBDIV			(*((volatile WORD32 *) 0xE01FC100))
#define	U0RBR			(*((volatile WORD32 *) 0xE000C000))

#define DESIRED_BAUDRATE 38400//19200

#define CRYSTAL_FREQUENCY_IN_HZ 12000000
#define PCLK CRYSTAL_FREQUENCY_IN_HZ	/* since VPBDIV=0x01	*/
#define DIVISOR (PCLK/(16*DESIRED_BAUDRATE))
#define	PCLK2SPI_CLK_DIVISOR	254//625

void InitUart0(void)
{

	//PCLK=CCLK(PROCESSOR CLK)
	APBDIV=0x01;

/* Select P0.0 as TxD0 and P0.1 as RxD0		*/
	PINSEL0 |= 0x00005105;			

/*	U0LCR: UART0 Line Control Register
	0x83: enable Divisor Latch access, set 8-bit word length,
	1 stop bit, no parity, disable break transmission		*/
	U0LCR=0x83;
	
/*	VPBDIV: VPB bus clock divider
	0x01: PCLK = processor clock		*/
	VPBDIV=0x01;
	
/*	U0DLL: UART0 Divisor Latch (LSB)	*/
	U0DLL=DIVISOR&0xFF;
	
/*	U0DLM: UART0 Divisor Latch (MSB)	*/
	U0DLM=DIVISOR>>8;
	
/*	U0LCR: UART0 Line Control Register
	0x03: same as above, but disable Divisor Latch access	*/
	U0LCR=0x03 ;
	
/*	U0FCR: UART0 FIFO Control Register
	0x05: Clear Tx FIFO and enable Rx and Tx FIFOs		*/
	U0FCR=0x05 ;
}

char putchar(char ch)
{
	if (ch=='\n')
	{
		//wait until Transmit Holding Register is empty
		while (!(U0LSR&0x20)) {}
		
		//then store to Transmit Holding Register
		U0THR='\r';
	}

	//wait until Transmit Holding Register is empty
	while (!(U0LSR&0x20)) {}
	//then store to Transmit Holding Register
	U0THR=ch;
	
	return ch;
}

char getchar(void)
{
	char ch;
	
	//wait until there's a character to be read
	while (!(U0LSR&0x01)) {}

	//then read from the Receiver Buffer Register
	ch=U0RBR;
	return ch;
}

int putint(int dat_tx)
{

	while (!(U0LSR&0x20)) {}
	//then store to Transmit Holding Register
	U0THR=dat_tx;
	
	return dat_tx;

}

int getint(void)
{
//int dat_rx;
	
	//wait until there's a character to be read
	while (!(U0LSR&0x01)) 
	{
	if(S0SPSR & 0x08)	//if slave is aborted i.e. ssel is high, then return.
	return 0;
	
	}

	//then read from the Receiver Buffer Register
	//dat_rx=U0RBR;
	//return dat_rx;
	return U0RBR;
}

////////////////////SPI////////////


/*
void SPI_Init (void)
{
	PINSEL0 |= 0x00005105;
	APBDIV=0x01;
	S0SPCCR = PCLK2SPI_CLK_DIVISOR ;
	S0SPCR = 0x084c ;	// slave mode, 8 bits per transfer
}
int SPI_Rx ()
{
	int value;
//	printf("receiving");
	while(!(S0SPSR&0x80)) ;
	value =  S0SPDR ;	// read and ignore status
	return value ;
}
*/
