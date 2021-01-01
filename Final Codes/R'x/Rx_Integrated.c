#include <Philips\LPC2148.h>
//#include "DACKBDLCD.h"

#define	VPBDIV			(*((volatile WORD32 *) 0xE01FC100))
#define	U0RBR			(*((volatile WORD32 *) 0xE000C000))

#define DESIRED_BAUDRATE 38400//19200

#define CRYSTAL_FREQUENCY_IN_HZ 12000000
#define PCLK CRYSTAL_FREQUENCY_IN_HZ	/* since VPBDIV=0x01	*/
#define DIVISOR (PCLK/(16*DESIRED_BAUDRATE))
#define	PCLK2SPI_CLK_DIVISOR	254  //625	625 = 19200
#define P0 IO0PIN

void SPI_Init (void)
{
	PINSEL0 |= 0x00005105;
	APBDIV=0x01;
	S0SPCCR = PCLK2SPI_CLK_DIVISOR ;
	S0SPCR = 0x084c ;	// slave mode, 8 bits per transfer
}
int SPI_Rx ()
{
	int value,a;
//	printf("receiving");
	while(!((a=S0SPSR)&0x80)) 
	{
		if(a&0x08) //if slave is aborted i.e. ssel is high, then return.
		{
			return 0;
		}
	}
//	value =  S0SPDR ;	// read and ignore status
//	printf("receiving %d",value);
//return value ;
	return S0SPDR ;
	
}



void Rx(void)
{
int dat,i, key[8],ssel_status;

InitUart0();
SPI_Init();
DAC_init();
//printf("Rx rst");
for(i=0; i <= 7 ; i ++)
{
key[i] = SPI_Rx();
}
//InitUart0();
//printf("%d",key[5] );


if (key[5] == 6)
{
	LcdInit();
	DisplayRow(1,"Welcome to MPTR!");
	DisplayRow(2,"Rx via SPI!");
	//DAC_init();
	//printf(" spi ");
	while(1)
	{
		//dat = getint();
		
	dac( dat = SPI_Rx());
//	DACR = SPI_Rx();
	printf("%d ",dat);
			//dac( dat = SPI_Rx());
//			printf(" SPI Rx ");
		//	printf("Rxed %d ",dat);
			//putint(dat);
			//dac(dat);
		
			//printf(" %d ",dat);
		//if(dat[5] && (~ dat[6]))
		//Rx();	
		//ssel_status = P0 & 0x80;
			if ((P0 & 0x80) == 0x80)//if (ssel_status == 0x80)//if (ssel_status == 0x80)	//
		{	//printf(" SPI rst ");
		main();
		} 
		
	}
}

else if (key[5] == 7)
{

	LcdInit();
	DisplayRow(1,"Welcome to MPTR!");
	DisplayRow(2,"Rx via UART!");
	//DAC_init();
//	printf(" UART ");
//InitUart0();
	while(1)
	{
	
			dac(dat = getint());
		//DACR = getint();
		//printf("Rxed %d ",dat);
			//dac(dat);
		
		
		//if(dat[5] && (~ dat[6]))
		//Rx();
		//ssel_status = P0 & 0x80;
		//if (ssel_status == 0x80)
		if ((P0 & 0x80) == 0x80)
		{
		//	printf(" uart rst  1");
		main();
		} 
	}
}

else if (key[5] == 10)
{

	main();

}

else
{

	main();

}

}
void main ()
{

//int dat[7],i, key[8],counter;
InitUart0();
LcdInit();
DisplayRow(1,"Welcome to MPTR!");
DisplayRow(2," RESET          ");
//SPI_Init();
//printf("main reset");
Rx();



/*
for(i=0; i <= 7 ; i ++)
{
key[i] = SPI_Rx();
}



if (key[5] == 6)
{
	LcdInit();
	DisplayRow(1,"Welcome to MPTR!");
	DisplayRow(2,"Rx via SPI!");
	while(1)
	{
		//dat = getint();
		for(counter = 0 ; counter<=7 ; counter ++)
		{
			dac( dat[counter] = SPI_Rx());
			
		//	printf("Rxed %d ",dat);
			//putint(dat);
			//dac(dat);
		}	
		
	}
}

else if (key[5] == 7)
{
	LcdInit();
	DisplayRow(1,"Welcome to MPTR!");
	DisplayRow(2,"Rx via UART!");
	while(1)
	{
		for(counter = 0 ; counter<=7 ; counter ++)
		{
			dac(dat[counter] = getint());
		//printf("Rxed %d ",dat);
			//dac(dat);
		}
		
		if(dat[5] && (~ dat[6]))
	}
}
*/



}


