#include <Philips\LPC2148.h>

#include "ADCKBDLCD.h"
//#include "UART0.h"

#define	VPBDIV			(*((volatile WORD32 *) 0xE01FC100))
#define	U0RBR			(*((volatile WORD32 *) 0xE000C000))

#define DESIRED_BAUDRATE 38400 //19200

#define CRYSTAL_FREQUENCY_IN_HZ 12000000
#define PCLK CRYSTAL_FREQUENCY_IN_HZ	/* since VPBDIV=0x01	*/
#define DIVISOR (PCLK/(16*DESIRED_BAUDRATE))
#define	PCLK2SPI_CLK_DIVISOR	254 //625 
#define P1 IO1PIN
//unsigned int x;
void t(void);

void InitUart0(void)
{

	//PCLK=CCLK(PROCESSOR CLK)
	APBDIV=0x01;

/* Select P0.0 as TxD0 and P0.1 as RxD0		*/
	PINSEL0 |= 0x00005505 ;			

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

int putint(int dat)
{
//x=dat;
	while (!(U0LSR&0x20)) {}
	//then store to Transmit Holding Register
	U0THR=dat;
	//printf("txed uart %d",x);
	return dat;
	

}






void SPI_Init (void)
{
	int j;
	S0SPCCR = PCLK2SPI_CLK_DIVISOR ;
	S0SPCR = 0x086c ;	// master mode, 8 bits per transfer
	APBDIV=0x01;
	PINSEL0 |= 0x00005505;
	IO0DIR |=0x00000400;
	for(j=0;j<1000;j++)
	{
	
	IO0SET |= 0x00000400;
	}
	IO0CLR |= 0x00000400;

}

void SPI_Tx (int value)
{
	S0SPDR = value ;
	while(!(S0SPSR&0x80)) ;
//	printf("txed %d", value);
}

void Tx()
{

//unsigned int kbd_key=0,i=0,a=0,j;

//LcdInit ();
//LcdInit ();
//DisplayRow (1, "                ");
//DisplayRow (2, "Welcome to MPTR!");

 

ADC_init();

SPI_Init() ;
InitUart0() ;
}

void t(){

unsigned int kbd_key=0,i=0;//,a=0,j;






kbd_key = keybord();
for(i=0;i<100;i++)
	{
	
	IO0SET |= 0x00000400;
	}
	IO0CLR |= 0x00000400;
	//SPI_Init() ;

		if( (kbd_key == 7)||(kbd_key == 6))
	{	
		printf("%d",kbd_key);
		for (i = 0; i <= 7; i++)  // common variable i for reducing delay in declaration
		SPI_Tx(kbd_key);
		//printf("key %d",kbd_key);
	}

		if (kbd_key == 7)
	{
		//InitUart0() ;
		//LcdInit ();
	
	//	printf("UART tx");
		//DisplayRow (1, "Welcome to MPTR!");
	//	DisplayRow (2, "Tx via UART");	
		//printf(" %d", ADC());
		while(1)
		{
			putint(ADC());
			//printf("Tx UART");
			IO1CLR=0x00040000;		//row_2 set to 0
			IO1SET=0x000b0000;
			/*IO1CLR=0x00010000;		//row_0 set to 0
			IO1SET=0x000e0000;*/
			//delay();
				//a=P1 & 0x00f00000;
				if((P1 & 0x00f00000) ==0x00d00000)
				{
				//printf("reset");
				
				//for(i=0;i<100;i++)
				IO0SET |= 0x00000400;
				//LcdInit ();
				//IO0CLR |= 0x00000400;
				//SPI_Init() ;
		
				t();//main();//Tx();//main()
				}	
		}	
	}
	
	if (kbd_key == 6)
	{
	//printf("SPI tx");	
	//LcdInit ();
		//DisplayRow (1, "Welcome to MPTR!");
	//	DisplayRow (2, "Tx via SPI");
		while(1)
		{
		
	//	for(temp = 1 ; temp <= 50 ; temp++ )
			SPI_Tx(ADC()) ;
			IO1CLR=0x00040000;		//row_2 set to 0
			IO1SET=0x000b0000;
			/*IO1CLR=0x00010000;		//row_0 set to 0
			IO1SET=0x000e0000;*/
			//delay();
			//a=P1 & 0x00f00000;
				if((P1 & 0x00f00000) ==0x00d00000)
				{	//col_2
			
					
				//for(i=0;i<100;i++)
				IO0SET |= 0x00000400;
				//LcdInit ();
				//IO0CLR |= 0x00000400;
				//SPI_Init() ;
			    t();//	main();// Tx();//main()
			    }
		}
	}
	
	  if (kbd_key == 10)
	{

				//LcdInit ();
				//for(i=0;i<100;i++)
				IO0SET |= 0x00000400;
				//IO0CLR |= 0x00000400;

		t();//main();//Tx();//main()
	
	}
	
	else
	{
		//LcdInit ();
		 main();//Tx();
	}

}

int main ()
{
	//int temp ;
	
	
	LcdInit ();
	DisplayRow (1, "Welcome to MPTR!");
	DisplayRow (2, "6spi,7uart,10rst");
//	LcdDat('H');
//	LcdDat('i');
	
	//InitUart0() ;
	//printf(" key %d",kbd_key);
//	SPI_Init() ;

	Tx();
	t();
	

	
/*	kbd_key = keybord();
	
for (i = 0; i <= 7; i++)
 SPI_Tx(kbd_key);

		if (kbd_key == 6)
	{
		LcdInit ();
		DisplayRow (1, "Welcome to MPTR!");
		DisplayRow (2, "Tx via SPI");
		while(1)
		{
		
	//	for(temp = 1 ; temp <= 50 ; temp++ )
			SPI_Tx(ADC()) ;
		}
	}
	
	else if (kbd_key == 7)
	{
		LcdInit ();
		DisplayRow (1, "Welcome to MPTR!");
		DisplayRow (2, "Tx via UART");	
		//printf(" %d", ADC());
		while(1){
		putint(ADC());
		
		}
	}
		
*/
}





	 





