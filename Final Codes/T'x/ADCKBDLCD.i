#line 1 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"
#line 1 "E:\SCARM\Inc\/Philips\LPC2148.h"

#line 6 "E:\SCARM\Inc\/Philips\LPC2148.h"



	typedef unsigned long int WORD32;
	typedef unsigned short int WORD16;
	typedef unsigned char BYTE;





































































































































































































































































#line 2 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"
#line 1 "E:\SCARM\Inc\/stdio.h"

#line 4 "E:\SCARM\Inc\/stdio.h"





char putchar (char ch) ;
char getchar (void) ;
void puts (char *str) ;

int printf (char *format, ...) ;
int sprintf (char *buf, char *format, ...);

int scanf (char *format, ...);
int sscanf (char *buf, char *format, ...);


#line 3 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"




extern unsigned char b;


#line 156 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"


void ADC_init(void)
{

(*((volatile WORD32 *) 0xE002C004))|=0x01000005;
SmallDelay();
(*((volatile WORD32 *) 0xE0034000))=0x0025a502;

}
 ADC(void)
{


#line 172 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"
while(!((*((volatile WORD32 *) 0xE0034030))&0x00000002))
{

}

#line 186 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"


return ((((*((volatile WORD32 *) 0xE0034014))>>6)&0x000003ff)/4);


}




#line 200 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"
void SmallDelay(void)
{

	int i;
	for(i=0;i<100;i++);
}

void LcdCmd1 (unsigned char cmd)
{


	if (cmd & 0x01)
(*((volatile WORD32 *) 0xE0028004)) = (1<<15);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<15);


	if (cmd & 0x02)
(*((volatile WORD32 *) 0xE0028004)) = (1<<17);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<17);


	if (cmd & 0x04)
(*((volatile WORD32 *) 0xE0028004)) = (1<<22);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<22);


	if (cmd & 0x08)
(*((volatile WORD32 *) 0xE0028004)) = (1<<30);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<30);


(*((volatile WORD32 *) 0xE002801C)) = 0x03000000  ;
	SmallDelay() ;

(*((volatile WORD32 *) 0xE0028014)) = 0x01000000  ;

	SmallDelay() ;

(*((volatile WORD32 *) 0xE002801C)) = 0x01000000  ;

	SmallDelay() ;
}

void LcdDat1 (unsigned char dat)
{

	if (dat & 0x01)
(*((volatile WORD32 *) 0xE0028004)) = (1<<15);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<15);


	if (dat & 0x02)
(*((volatile WORD32 *) 0xE0028004)) = (1<<17);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<17);


	if (dat & 0x04)
(*((volatile WORD32 *) 0xE0028004)) = (1<<22);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<22);


	if (dat & 0x08)
(*((volatile WORD32 *) 0xE0028004)) = (1<<30);
	else
(*((volatile WORD32 *) 0xE002800C)) = (1<<30);


(*((volatile WORD32 *) 0xE0028014)) = 0x02000000  ;

	SmallDelay() ;

(*((volatile WORD32 *) 0xE002801C)) = 0x01000000  ;

	SmallDelay() ;

(*((volatile WORD32 *) 0xE0028014)) = 0x01000000  ;

	SmallDelay() ;

(*((volatile WORD32 *) 0xE002801C)) = 0x01000000  ;

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


(*((volatile WORD32 *) 0xE01FC100))=0x01;

(*((volatile WORD32 *) 0xE0028018)) |= 0x03400000  ;
(*((volatile WORD32 *) 0xE002801C)) = 0x03000000  ;

(*((volatile WORD32 *) 0xE0028008)) |= 0x40428000  ;
(*((volatile WORD32 *) 0xE002800C)) = 0x40428000  ;

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

#line 360 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"
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









unsigned int keybord(void)
{

unsigned int a,key=15, b;

up:
(*((volatile WORD32 *) 0xE0028010))=0x00000000;
(*((volatile WORD32 *) 0xE002C014)) |=0x00000000;

(*((volatile WORD32 *) 0xE0028018)) |=0x000f0000;


(*((volatile WORD32 *) 0xE0028014)) =0x00f00000;
(*((volatile WORD32 *) 0xE002801C)) =0x000f0000;


	delay();
	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;

	 if(a==0x00f00000)
		goto up;
	else if(a!=0x00f00000)
		goto check;

	check:
	delay();
(*((volatile WORD32 *) 0xE002801C))=0x000f0000;

	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;
	if(a!=0x00f00000){

		goto check1;
		}
	else
		goto up;

	check1:

(*((volatile WORD32 *) 0xE002801C))=0x00010000;
(*((volatile WORD32 *) 0xE0028014))=0x000e0000;

	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;
	 if(a!=0x00f00000)
	{

		goto row_0;
		}





(*((volatile WORD32 *) 0xE002801C))=0x00020000;
(*((volatile WORD32 *) 0xE0028014))=0x000d0000;

	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;
	 if(a!=0x00f00000)
	{

		goto row_1;
	}



(*((volatile WORD32 *) 0xE002801C))=0x00040000;
(*((volatile WORD32 *) 0xE0028014))=0x000b0000;

	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;
	 if(a!=0x00f00000)
	{

		goto row_2;
		}



(*((volatile WORD32 *) 0xE002801C))=0x00080000;
(*((volatile WORD32 *) 0xE0028014))=0x00070000;

	a=(*((volatile WORD32 *) 0xE0028010)) & 0x00f00000;
	 if(a!=0x00f00000)
	{

		goto row_3;
	}



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

	if(a==0x00e00000)
	{

		b=b+3;

		}
	else if(a==0x00d00000)
	{

		b=b+2;

		}
	else if(a==0x00b00000)
	{

		b=b+1;

		}
	else if(a==0x00700000)
	{

		b=b;

		}
	else goto up;


#line 522 "E:\diploma mpt\Final Codes\T'x\ADCKBDLCD.c"

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