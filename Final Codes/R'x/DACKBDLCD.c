#include <Philips\LPC2148.h>
#include<stdio.h>
//#include "ADCKBDLCD.h"

#define P0 IO0PIN
extern unsigned char b;

/////////////////KEYBOARD////////////

unsigned char keybord(void)
{

int a,key=15;
unsigned char b;

up:
	IO0DIR |=0x0000f000;         	  //set rows as output
	
	//printf("\n no key pressed");
	IO0SET=0x000f0000;
	IO0CLR=0x0000f000;		//all rows 0
	delay();
	a=P0 & 0x000f0000;
	if(a==0x000f0000)		//is key pressed?
		goto up;
	else if(a!=0x000f0000)
		goto check;
	
	check:
	delay();			//keydebouncing delay
	IO0CLR=0x0000f000;
	//delay();
	a=P0 & 0x000f0000;
	if(a!=0x000f0000)
		//while ((P0&0x000f0000))
		goto check1;
	else
		goto up;

	check1:
	
	IO0CLR=0x00001000;		//row_0 set to 0
	IO0SET=0x0000e000;
	//delay();
	a=P0 & 0x000f0000;
	if(a!=0x000f0000)
	{
	//printf("\n row 0");
		goto row_0;
		}
		//while (!(P0&0x000f0000))
		//goto row_0;
	//else
		

	IO0CLR=0x00002000;		//row_1 set to 0
	IO0SET=0x0000d000;
	//delay();
	a=P0 & 0x000f0000;
	if(a!=0x000f0000)
	{
	//printf("\n row 1");
		goto row_1;
	}
	
	//while (!(P0&0x000f0000))
	//	goto row_1;
	IO0CLR=0x00004000;		//row_2 set to 0
	IO0SET=0x0000b000;
	//delay();
	a=P0 & 0x000f0000;
	if(a!=0x000f0000)
	{
	//printf("\n row 2");
		goto row_2;
		}

//while (!(P0&0x000f0000))
//		goto row_2;
	IO0CLR=0x00008000;		//row_3 set to 0
	IO0SET=0x00007000;
	//delay();
	a=P0 & 0x000f0000;
	if(a!=0x000f0000)
	{
	//printf("\n row 3");
		goto row_3;
	}
	
	//while (!(P0&0x000f0000))
	//	goto row_3;
	goto up;

	row_0:
		b=0;
  		goto down;
	row_1:
		b=4;
  		goto down;
	row_2:
		b=8;
  		goto down;
	row_3:
		b=12;
  		

	down:
	
	if(a==0x000e0000)
	{
	//printf("\n column 3");
		b=b+3;
		//goto keyfound;
		}
	else if(a==0x000d0000)
	{
	//printf("\n column 2");
		b=b+2;
		//goto keyfound;
		}
	else if(a==0x000b0000)
	{
	//printf("\n column 1");
		b=b+1;
		//goto keyfound;
		}
	else if(a==0x00070000)
	{
	//printf("\n column 0");
		b=b;	
		//goto keyfound;
		}
	else goto up;	

/*keyfound:
if(b==15)
goto up;*/
//printf("\n \nkey= %d ",b);
	return(b);


}

delay(void)
{
int aa,bb;
for(aa=0;aa<100;aa++)
	{
	for(bb=0;bb<100;bb++)
		{
		}
}
return 0;
}



/////////////////ADC////////////

 ADC(void)
{
unsigned short int data,datum,d8bit;
PINSEL1 |=0x01000005;
delay();
AD0CR=0x0025a502;
while(!(AD0STAT&0x00000002))
{
//printf("\nconversion not completed");
}
data=AD0DR1;
//printf("\nconversion completed AD0DR1=%d",AD0DR1);

datum=(data>>6)&0x000003ff;
//printf("\nconverted data=%d",datum);

d8bit=datum/4;		//10 bit to 8 bit
delay();
//printf("\n8bit equivalent data=%d",d8bit);
AD0CR=0x00000000;
return (d8bit);
}


///////////////////DAC/////////////////
void DAC_init(void)
{
PINSEL1 |= 0x00080000 ;
}

dac(int datum)
{
//int delay;
//PINSEL1 |= 0x00080000 ;


//for(delay=0;delay<80;delay++)
//{
DACR = datum <<8;
//}
//DACR=0x0000ffc0;
//return 0;
}





/////////////////LCD////////////

void SmallDelay (void)
{

	int i;
	for(i=0;i<100;i++);	
}

void LcdCmd1 (unsigned char cmd)
{

	// send command on on data lines (D4 to D7)
	if (cmd & 0x01)
		IO0SET = (1<<15);
	else
		IO0CLR = (1<<15);
		

	if (cmd & 0x02)
		IO0SET = (1<<17);
	else
		IO0CLR = (1<<17);
		

	if (cmd & 0x04)
		IO0SET = (1<<22);
	else
		IO0CLR = (1<<22);
		

	if (cmd & 0x08)
		IO0SET = (1<<30);
	else
		IO0CLR = (1<<30);
		

	IO1CLR = 0x03000000  ;	// CLEAR(0) RS and EN 
	SmallDelay() ;

	IO1SET = 0x01000000  ;	// SET(1) EN 

	SmallDelay() ;

	IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

	SmallDelay() ;
}

void LcdDat1 (unsigned char dat)
{
	// send data on on data lines (D4 to D7)
	if (dat & 0x01)
		IO0SET = (1<<15);
	else
		IO0CLR = (1<<15);
		

	if (dat & 0x02)
		IO0SET = (1<<17);
	else
		IO0CLR = (1<<17);
		

	if (dat & 0x04)
		IO0SET = (1<<22);
	else
		IO0CLR = (1<<22);
		

	if (dat & 0x08)
		IO0SET = (1<<30);
	else
		IO0CLR = (1<<30);
		
	
	IO1SET = 0x02000000  ;	// SET(1) RS 
	
	SmallDelay() ;
	
	IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

	SmallDelay() ;	
		
	IO1SET = 0x01000000  ;	// SET(1) EN 

	SmallDelay() ;

	IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

	SmallDelay() ;	
}
void Delay250 (void)
{
	int k,j ;
	j =200 ;
	for(k = 0 ; k < 100 ; k ++)
	{
		j-- ;
	}
}
void DelayMs (int n)
{
	int k ;
	for(k = 0 ; k < n ; k ++)
	{
		Delay250() ;
		Delay250() ;
	}
}
void LcdCmd (unsigned char cmd)
{
	LcdCmd1(cmd >> 4) ;
	LcdCmd1(cmd) ;
	Delay250() ;
	Delay250() ;
}
void LcdDat (unsigned char dat)
{
	LcdDat1(dat >> 4) ;
	LcdDat1(dat) ;
	Delay250() ;
	Delay250() ;
}
void LcdInit (void)
{

	//PCLK=CCLK(PROCESSOR CLK)
	APBDIV=0x01;
	
	IO1DIR |= 0x03000000  ;		// Configure P1.24(EN) and P1.25(RS) as Output
	IO1CLR = 0x03000000  ;		// CLEAR(0) P1.24(EN) and P1.25(RS)

	IO0DIR |= 0x40428000  ;		// Configure P0.15(D4), P0.17(D5), P0.22(D6) and P0.30(D7) as Output
	IO0CLR = 0x40428000  ;		// CLEAR(0) P0.15(D4), P0.17(D5), P0.22(D6) and P0.30(D7)

	DelayMs(6) ;
	LcdCmd1(0x03) ;
	
	DelayMs(6) ;
	LcdCmd1(0x03) ;
	Delay250() ;

	LcdCmd1(0x03) ;
	Delay250() ;

	LcdCmd1(0x02) ;
	Delay250() ;


	LcdCmd(0x28) ;
	LcdCmd(0x08) ;
	LcdCmd(0x0c) ;
	LcdCmd(0x06) ;

}
void DisplayRow (int row, char *str)
{
/*
	pass pointer to 16 character string
	displayes the message on line1 or line2 of LCD, depending on whether row is 1 or 2.
*/
	int k ;

	if (row == 1)
		LcdCmd(0x80) ;
	else
		LcdCmd(0xc0) ;
	for(k = 0 ; k < 16 ; k ++)
	{
		if (str[k])
			LcdDat(str[k]) ;
		else
			break ;
	}
	while(k < 16)
	{
		LcdDat(' ') ;
		k ++ ;
	}
}

 