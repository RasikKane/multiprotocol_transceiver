.file 1 "ADCKBDLCD.c"

	.global ADC_init

	.text
	@------------- locals ---------------------

	.p2align 2

	.text
ADC_init:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R6, R11, R12, lr}
	mov R11,R13

@line 159,0	{

.loc 1 159 0

@line 161,0	PINSEL1|=0x01000005;

.loc 1 161 0
	ldr	R4, LIT.ADC_init0+0
	ldr	R5,[R4]
	ldr	R6, LIT.ADC_init0+4
	orr R5, R5, R6
	str	R5, [R4]

@line 162,0	SmallDelay();

.loc 1 162 0
	bl	SmallDelay

@line 163,0	AD0CR=0x0025a502;

.loc 1 163 0
	ldr	R4, LIT.ADC_init0+8
	ldr	R5, LIT.ADC_init0+12
	str	R5, [R4]

@line 165,0	}

.loc 1 165 0
L.1:
	ldmfd	R11, {R4, R5, R6, R11, sp, pc}

	.p2align 2
LIT.ADC_init0:
	.word 0xE002C004
	.word 0x1000005
	.word 0xE0034000
	.word 0x25A502



	.global ADC

	.p2align 2

	.text
ADC:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R11, R12, lr}
	mov R11,R13

@line 167,0	{

.loc 1 167 0
L.3:

@line 173,0	{

.loc 1 173 0

@line 175,0	}

.loc 1 175 0
L.4:

@line 172,6	
.loc 1 172 6
	ldr	R4, LIT.ADC0+0
	ldr	R4,[R4]
	mov	R5, #2

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.3

@line 188,7	return (((AD0DR1>>6)&0x000003ff)/4);

.loc 1 188 7
	ldr	R4, LIT.ADC0+4
	ldr	R4,[R4]
	mov	R5, #6

	mov R4, R4, lsr R5
	mov	R5, #1020
	add	R5, R5, #3

	and R4, R4, R5
	mov	R5, #2

	mov R4, R4, lsr R5
	mov	R0, R4
L.2:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2
LIT.ADC0:
	.word 0xE0034030
	.word 0xE0034014



	.global SmallDelay
	@------------- locals ---------------------
	@i -- R11 - (4)

	.p2align 2

	.text
SmallDelay:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R11, R12, lr}
	mov R11,R13
	sub	sp, sp, #1 * 4

@line 201,0	{

.loc 1 201 0

@line 204,5		for(i=0;i<100;i++);	

.loc 1 204 5
	mov	R4, #0

	str	R4, [R11, #-4]
L.7:

@line 204,19	
.loc 1 204 19
L.8:

@line 204,15	
.loc 1 204 15
	ldr	R4,[R11, #-4]
	add	R4, R4, #1
	str	R4, [R11, #-4]

@line 204,9	
.loc 1 204 9
	ldr	R4,[R11, #-4]
	mov	R5, #100

	cmp	R4,R5
	blt	L.7

@line 205,0	}

.loc 1 205 0
L.6:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global LcdCmd1
	@------------- parameters -----------------
	@cmd -- R11 - (4)

	.p2align 2

	.text
LcdCmd1:
	mov	R12, sp
	stmfd	sp!, {R0, R4, R5, R11, R12, lr}
	add R11,R13,#4
	ldr	R4,[R11, #-4]
	strb	R4, [R11, #-4]

@line 208,0	{

.loc 1 208 0

@line 211,5		if (cmd & 0x01)

.loc 1 211 5
	ldrb	R4,[R11, #-4]
	mov	R5, #1

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.12

@line 212,0			IO0SET = (1<<15);

.loc 1 212 0
	ldr	R4, LIT.LcdCmd10+0
	ldr	R5, LIT.LcdCmd10+4
	str	R5, [R4]
	b	L.13
L.12:

@line 214,0			IO0CLR = (1<<15);

.loc 1 214 0
	ldr	R4, LIT.LcdCmd10+8
	ldr	R5, LIT.LcdCmd10+4
	str	R5, [R4]
L.13:

@line 217,5		if (cmd & 0x02)

.loc 1 217 5
	ldrb	R4,[R11, #-4]
	mov	R5, #2

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.14

@line 218,0			IO0SET = (1<<17);

.loc 1 218 0
	ldr	R4, LIT.LcdCmd10+0
	ldr	R5, LIT.LcdCmd10+12
	str	R5, [R4]
	b	L.15
L.14:

@line 220,0			IO0CLR = (1<<17);

.loc 1 220 0
	ldr	R4, LIT.LcdCmd10+8
	ldr	R5, LIT.LcdCmd10+12
	str	R5, [R4]
L.15:

@line 223,5		if (cmd & 0x04)

.loc 1 223 5
	ldrb	R4,[R11, #-4]
	mov	R5, #4

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.16

@line 224,0			IO0SET = (1<<22);

.loc 1 224 0
	ldr	R4, LIT.LcdCmd10+0
	ldr	R5, LIT.LcdCmd10+16
	str	R5, [R4]
	b	L.17
L.16:

@line 226,0			IO0CLR = (1<<22);

.loc 1 226 0
	ldr	R4, LIT.LcdCmd10+8
	ldr	R5, LIT.LcdCmd10+16
	str	R5, [R4]
L.17:

@line 229,5		if (cmd & 0x08)

.loc 1 229 5
	ldrb	R4,[R11, #-4]
	mov	R5, #8

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.18

@line 230,0			IO0SET = (1<<30);

.loc 1 230 0
	ldr	R4, LIT.LcdCmd10+0
	ldr	R5, LIT.LcdCmd10+20
	str	R5, [R4]
	b	L.19
L.18:

@line 232,0			IO0CLR = (1<<30);

.loc 1 232 0
	ldr	R4, LIT.LcdCmd10+8
	ldr	R5, LIT.LcdCmd10+20
	str	R5, [R4]
L.19:

@line 235,0		IO1CLR = 0x03000000  ;	// CLEAR(0) RS and EN 

.loc 1 235 0
	ldr	R4, LIT.LcdCmd10+24
	ldr	R5, LIT.LcdCmd10+28
	str	R5, [R4]

@line 236,1		SmallDelay() ;

.loc 1 236 1
	bl	SmallDelay

@line 238,0		IO1SET = 0x01000000  ;	// SET(1) EN 

.loc 1 238 0
	ldr	R4, LIT.LcdCmd10+32
	ldr	R5, LIT.LcdCmd10+36
	str	R5, [R4]

@line 240,1		SmallDelay() ;

.loc 1 240 1
	bl	SmallDelay

@line 242,0		IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

.loc 1 242 0
	ldr	R4, LIT.LcdCmd10+24
	ldr	R5, LIT.LcdCmd10+36
	str	R5, [R4]

@line 244,1		SmallDelay() ;

.loc 1 244 1
	bl	SmallDelay

@line 245,0	}

.loc 1 245 0
L.11:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2
LIT.LcdCmd10:
	.word 0xE0028004
	.word 0x8000
	.word 0xE002800C
	.word 0x20000
	.word 0x400000
	.word 0x40000000
	.word 0xE002801C
	.word 0x3000000
	.word 0xE0028014
	.word 0x1000000



	.global LcdDat1
	@------------- parameters -----------------
	@dat -- R11 - (4)

	.p2align 2

	.text
LcdDat1:
	mov	R12, sp
	stmfd	sp!, {R0, R4, R5, R11, R12, lr}
	add R11,R13,#4
	ldr	R4,[R11, #-4]
	strb	R4, [R11, #-4]

@line 248,0	{

.loc 1 248 0

@line 250,5		if (dat & 0x01)

.loc 1 250 5
	ldrb	R4,[R11, #-4]
	mov	R5, #1

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.21

@line 251,0			IO0SET = (1<<15);

.loc 1 251 0
	ldr	R4, LIT.LcdDat10+0
	ldr	R5, LIT.LcdDat10+4
	str	R5, [R4]
	b	L.22
L.21:

@line 253,0			IO0CLR = (1<<15);

.loc 1 253 0
	ldr	R4, LIT.LcdDat10+8
	ldr	R5, LIT.LcdDat10+4
	str	R5, [R4]
L.22:

@line 256,5		if (dat & 0x02)

.loc 1 256 5
	ldrb	R4,[R11, #-4]
	mov	R5, #2

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.23

@line 257,0			IO0SET = (1<<17);

.loc 1 257 0
	ldr	R4, LIT.LcdDat10+0
	ldr	R5, LIT.LcdDat10+12
	str	R5, [R4]
	b	L.24
L.23:

@line 259,0			IO0CLR = (1<<17);

.loc 1 259 0
	ldr	R4, LIT.LcdDat10+8
	ldr	R5, LIT.LcdDat10+12
	str	R5, [R4]
L.24:

@line 262,5		if (dat & 0x04)

.loc 1 262 5
	ldrb	R4,[R11, #-4]
	mov	R5, #4

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.25

@line 263,0			IO0SET = (1<<22);

.loc 1 263 0
	ldr	R4, LIT.LcdDat10+0
	ldr	R5, LIT.LcdDat10+16
	str	R5, [R4]
	b	L.26
L.25:

@line 265,0			IO0CLR = (1<<22);

.loc 1 265 0
	ldr	R4, LIT.LcdDat10+8
	ldr	R5, LIT.LcdDat10+16
	str	R5, [R4]
L.26:

@line 268,5		if (dat & 0x08)

.loc 1 268 5
	ldrb	R4,[R11, #-4]
	mov	R5, #8

	and R4, R4, R5
	mov	R5, #0

	cmp	R4,R5
	beq	L.27

@line 269,0			IO0SET = (1<<30);

.loc 1 269 0
	ldr	R4, LIT.LcdDat10+0
	ldr	R5, LIT.LcdDat10+20
	str	R5, [R4]
	b	L.28
L.27:

@line 271,0			IO0CLR = (1<<30);

.loc 1 271 0
	ldr	R4, LIT.LcdDat10+8
	ldr	R5, LIT.LcdDat10+20
	str	R5, [R4]
L.28:

@line 274,0		IO1SET = 0x02000000  ;	// SET(1) RS 

.loc 1 274 0
	ldr	R4, LIT.LcdDat10+24
	ldr	R5, LIT.LcdDat10+28
	str	R5, [R4]

@line 276,1		SmallDelay() ;

.loc 1 276 1
	bl	SmallDelay

@line 278,0		IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

.loc 1 278 0
	ldr	R4, LIT.LcdDat10+32
	ldr	R5, LIT.LcdDat10+36
	str	R5, [R4]

@line 280,1		SmallDelay() ;	

.loc 1 280 1
	bl	SmallDelay

@line 282,0		IO1SET = 0x01000000  ;	// SET(1) EN 

.loc 1 282 0
	ldr	R4, LIT.LcdDat10+24
	ldr	R5, LIT.LcdDat10+36
	str	R5, [R4]

@line 284,1		SmallDelay() ;

.loc 1 284 1
	bl	SmallDelay

@line 286,0		IO1CLR = 0x01000000  ;	// CLEAR(0) EN 

.loc 1 286 0
	ldr	R4, LIT.LcdDat10+32
	ldr	R5, LIT.LcdDat10+36
	str	R5, [R4]

@line 288,1		SmallDelay() ;	

.loc 1 288 1
	bl	SmallDelay

@line 289,0	}

.loc 1 289 0
L.20:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2
LIT.LcdDat10:
	.word 0xE0028004
	.word 0x8000
	.word 0xE002800C
	.word 0x20000
	.word 0x400000
	.word 0x40000000
	.word 0xE0028014
	.word 0x2000000
	.word 0xE002801C
	.word 0x1000000



	.global Delay250
	@------------- locals ---------------------
	@j -- R11 - (8)
	@k -- R11 - (4)

	.p2align 2

	.text
Delay250:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R11, R12, lr}
	mov R11,R13
	sub	sp, sp, #2 * 4

@line 291,0	{

.loc 1 291 0

@line 293,1		j =200 ;

.loc 1 293 1
	mov	R4, #200

	str	R4, [R11, #-8]

@line 294,5		for(k = 0 ; k < 100 ; k ++)

.loc 1 294 5
	mov	R4, #0

	str	R4, [R11, #-4]
L.30:

@line 295,1		{

.loc 1 295 1

@line 296,2			j-- ;

.loc 1 296 2
	ldr	R4,[R11, #-8]
	sub	R4, R4, #1
	str	R4, [R11, #-8]

@line 297,1		}

.loc 1 297 1
L.31:

@line 294,23	
.loc 1 294 23
	ldr	R4,[R11, #-4]
	add	R4, R4, #1
	str	R4, [R11, #-4]

@line 294,13	
.loc 1 294 13
	ldr	R4,[R11, #-4]
	mov	R5, #100

	cmp	R4,R5
	blt	L.30

@line 298,0	}

.loc 1 298 0
L.29:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global DelayMs
	@------------- parameters -----------------
	@n -- R11 - (4)
	@------------- locals ---------------------
	@k -- R11 - (8)

	.p2align 2

	.text
DelayMs:
	mov	R12, sp
	stmfd	sp!, {R0, R4, R5, R11, R12, lr}
	add R11,R13,#4
	sub	sp, sp, #1 * 4

@line 300,0	{

.loc 1 300 0

@line 302,5		for(k = 0 ; k < n ; k ++)

.loc 1 302 5
	mov	R4, #0

	str	R4, [R11, #-8]
	b	L.38
L.35:

@line 303,1		{

.loc 1 303 1

@line 304,2			Delay250() ;

.loc 1 304 2
	bl	Delay250

@line 305,2			Delay250() ;

.loc 1 305 2
	bl	Delay250

@line 306,1		}

.loc 1 306 1
L.36:

@line 302,21	
.loc 1 302 21
	ldr	R4,[R11, #-8]
	add	R4, R4, #1
	str	R4, [R11, #-8]
L.38:

@line 302,13	
.loc 1 302 13
	ldr	R4,[R11, #-8]
	ldr	R5,[R11, #-4]
	cmp	R4,R5
	blt	L.35

@line 307,0	}

.loc 1 307 0
L.34:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global LcdCmd
	@------------- parameters -----------------
	@cmd -- R11 - (4)

	.p2align 2

	.text
LcdCmd:
	mov	R12, sp
	stmfd	sp!, {R0, R4, R5, R11, R12, lr}
	add R11,R13,#4
	sub	sp, sp, #1 * 4
	ldr	R4,[R11, #-4]
	strb	R4, [R11, #-4]

@line 309,0	{

.loc 1 309 0

@line 310,1		LcdCmd1(cmd >> 4) ;

.loc 1 310 1
	ldrb	R4,[R11, #-4]
	mov	R5, #4

	mov R4, R4, asr R5
	and	R0,R4,#255
	bl	LcdCmd1

@line 311,1		LcdCmd1(cmd) ;

.loc 1 311 1
	ldrb	R0,[R11, #-4]
	bl	LcdCmd1

@line 312,1		Delay250() ;

.loc 1 312 1
	bl	Delay250

@line 313,1		Delay250() ;

.loc 1 313 1
	bl	Delay250

@line 314,0	}

.loc 1 314 0
L.39:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global LcdDat
	@------------- parameters -----------------
	@dat -- R11 - (4)

	.p2align 2

	.text
LcdDat:
	mov	R12, sp
	stmfd	sp!, {R0, R4, R5, R11, R12, lr}
	add R11,R13,#4
	sub	sp, sp, #1 * 4
	ldr	R4,[R11, #-4]
	strb	R4, [R11, #-4]

@line 316,0	{

.loc 1 316 0

@line 317,1		LcdDat1(dat >> 4) ;

.loc 1 317 1
	ldrb	R4,[R11, #-4]
	mov	R5, #4

	mov R4, R4, asr R5
	and	R0,R4,#255
	bl	LcdDat1

@line 318,1		LcdDat1(dat) ;

.loc 1 318 1
	ldrb	R0,[R11, #-4]
	bl	LcdDat1

@line 319,1		Delay250() ;

.loc 1 319 1
	bl	Delay250

@line 320,1		Delay250() ;

.loc 1 320 1
	bl	Delay250

@line 321,0	}

.loc 1 321 0
L.40:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global LcdInit
	@------------- locals ---------------------

	.p2align 2

	.text
LcdInit:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R6, R11, R12, lr}
	mov R11,R13
	sub	sp, sp, #1 * 4

@line 323,0	{

.loc 1 323 0

@line 326,0		APBDIV=0x01;

.loc 1 326 0
	ldr	R4, LIT.LcdInit0+0
	mov	R5, #1

	str	R5, [R4]

@line 328,0		IO1DIR |= 0x03400000  ;		// Configure P1.24(EN) and P1.25(RS) as Output

.loc 1 328 0
	ldr	R4, LIT.LcdInit0+4
	ldr	R5,[R4]
	ldr	R6, LIT.LcdInit0+8
	orr R5, R5, R6
	str	R5, [R4]

@line 329,0		IO1CLR = 0x03000000  ;		// CLEAR(0) P1.24(EN) and P1.25(RS)

.loc 1 329 0
	ldr	R4, LIT.LcdInit0+12
	ldr	R5, LIT.LcdInit0+16
	str	R5, [R4]

@line 331,0		IO0DIR |= 0x40428000  ;		// Configure P0.15(D4), P0.17(D5), P0.22(D6) and P0.30(D7) as Output 

.loc 1 331 0
	ldr	R4, LIT.LcdInit0+20
	ldr	R5,[R4]
	ldr	R6, LIT.LcdInit0+24
	orr R5, R5, R6
	str	R5, [R4]

@line 332,0		IO0CLR = 0x40428000  ;		// CLEAR(0) P0.15(D4), P0.17(D5), P0.22(D6) and P0.30(D7)

.loc 1 332 0
	ldr	R4, LIT.LcdInit0+28
	ldr	R5, LIT.LcdInit0+24
	str	R5, [R4]

@line 334,1		DelayMs(6) ;

.loc 1 334 1
	mov	R0, #6

	bl	DelayMs

@line 335,1		LcdCmd1(0x03) ;

.loc 1 335 1
	mov	R0, #3

	bl	LcdCmd1

@line 337,1		DelayMs(6) ;

.loc 1 337 1
	mov	R0, #6

	bl	DelayMs

@line 338,1		LcdCmd1(0x03) ;

.loc 1 338 1
	mov	R0, #3

	bl	LcdCmd1

@line 339,1		Delay250() ;

.loc 1 339 1
	bl	Delay250

@line 341,1		LcdCmd1(0x03) ;

.loc 1 341 1
	mov	R0, #3

	bl	LcdCmd1

@line 342,1		Delay250() ;

.loc 1 342 1
	bl	Delay250

@line 344,1		LcdCmd1(0x02) ;

.loc 1 344 1
	mov	R0, #2

	bl	LcdCmd1

@line 345,1		Delay250() ;

.loc 1 345 1
	bl	Delay250

@line 348,1		LcdCmd(0x28) ;

.loc 1 348 1
	mov	R0, #40

	bl	LcdCmd

@line 349,1		LcdCmd(0x08) ;

.loc 1 349 1
	mov	R0, #8

	bl	LcdCmd

@line 350,1		LcdCmd(0x0c) ;

.loc 1 350 1
	mov	R0, #12

	bl	LcdCmd

@line 351,1		LcdCmd(0x06) ;

.loc 1 351 1
	mov	R0, #6

	bl	LcdCmd

@line 353,0	}

.loc 1 353 0
L.41:
	ldmfd	R11, {R4, R5, R6, R11, sp, pc}

	.p2align 2
LIT.LcdInit0:
	.word 0xE01FC100
	.word 0xE0028018
	.word 0x3400000
	.word 0xE002801C
	.word 0x3000000
	.word 0xE0028008
	.word 0x40428000
	.word 0xE002800C



	.global DisplayRow
	@------------- parameters -----------------
	@str -- R11 - (4)
	@row -- R11 - (8)
	@------------- locals ---------------------
	@k -- R11 - (12)

	.p2align 2

	.text
DisplayRow:
	mov	R12, sp
	stmfd	sp!, {R0, R1, R4, R5, R11, R12, lr}
	add R11,R13,#8
	sub	sp, sp, #2 * 4

@line 355,0	{

.loc 1 355 0

@line 362,5		if (row == 1)

.loc 1 362 5
	ldr	R4,[R11, #-8]
	mov	R5, #1

	cmp	R4,R5
	bne	L.43

@line 363,2			LcdCmd(0x80) ;

.loc 1 363 2
	mov	R0, #128

	bl	LcdCmd
	b	L.44
L.43:

@line 365,2			LcdCmd(0xc0) ;

.loc 1 365 2
	mov	R0, #192

	bl	LcdCmd
L.44:

@line 366,5		for(k = 0 ; k < 16 ; k ++)

.loc 1 366 5
	mov	R4, #0

	str	R4, [R11, #-12]
L.45:

@line 367,1		{

.loc 1 367 1

@line 368,6			if (str[k])

.loc 1 368 6
	ldr	R4,[R11, #-12]
	ldr	R5,[R11, #-4]
	add	R4, R4, R5
	ldrsb	R4,[R4]
	mov	R5, #0

	cmp	R4,R5
	beq	L.52

@line 369,3				LcdDat(str[k]) ;

.loc 1 369 3
	ldr	R4,[R11, #-12]
	ldr	R5,[R11, #-4]
	add	R4, R4, R5
	ldrsb	R4,[R4]
	and	R0,R4,#255
	bl	LcdDat

@line 371,3				break ;

.loc 1 371 3
L.50:

@line 372,1		}

.loc 1 372 1
L.46:

@line 366,22	
.loc 1 366 22
	ldr	R4,[R11, #-12]
	add	R4, R4, #1
	str	R4, [R11, #-12]

@line 366,13	
.loc 1 366 13
	ldr	R4,[R11, #-12]
	mov	R5, #16

	cmp	R4,R5
	blt	L.45
	b	L.52
L.51:

@line 374,1		{

.loc 1 374 1

@line 375,2			LcdDat(' ') ;

.loc 1 375 2
	mov	R0, #32

	bl	LcdDat

@line 376,2			k ++ ;

.loc 1 376 2
	ldr	R4,[R11, #-12]
	add	R4, R4, #1
	str	R4, [R11, #-12]

@line 377,1		}

.loc 1 377 1
L.52:

@line 373,7	
.loc 1 373 7
	ldr	R4,[R11, #-12]
	mov	R5, #16

	cmp	R4,R5
	blt	L.51

@line 378,0	}

.loc 1 378 0
L.42:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2


	.global keybord
	@------------- locals ---------------------
	@a -- R11 - (4)
	@b -- R11 - (8)
	@key -- R11 - (12)

	.p2align 2

	.text
keybord:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R6, R11, R12, lr}
	mov R11,R13
	sub	sp, sp, #3 * 4

@line 389,0	{

.loc 1 389 0

@line 391,19	unsigned int a,key=15, b;

.loc 1 391 19
	mov	R4, #15

	str	R4, [R11, #-12]
L.55:

@line 394,0		P1=0x00000000;

.loc 1 394 0
	ldr	R4, LIT.keybord0+0
	mov	R5, #0

	str	R5, [R4]

@line 395,0		PINSEL2 |=0x00000000;

.loc 1 395 0
	ldr	R4, LIT.keybord0+4
	ldr	R5,[R4]
	str	R5, [R4]

@line 397,0		 IO1DIR |=0x000f0000;         	  //set rows as output

.loc 1 397 0
	ldr	R4, LIT.keybord0+8
	ldr	R5,[R4]
	ldr	R6, LIT.keybord0+12
	orr R5, R5, R6
	str	R5, [R4]

@line 400,0		IO1SET =0x00f00000;

.loc 1 400 0
	ldr	R4, LIT.keybord0+16
	ldr	R5, LIT.keybord0+20
	str	R5, [R4]

@line 401,0		IO1CLR =0x000f0000;		//all rows 0

.loc 1 401 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+12
	str	R5, [R4]

@line 404,1		delay();

.loc 1 404 1
	bl	delay

@line 405,1		a=P1 & 0x00f00000;

.loc 1 405 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 407,5		 if(a==0x00f00000)		//is key pressed?

.loc 1 407 5
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	bne	L.56

@line 408,2			goto up;

.loc 1 408 2
	b	L.55
L.56:

@line 409,9		else if(a!=0x00f00000)

.loc 1 409 9
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.58

@line 410,2			goto check;

.loc 1 410 2
L.58:
L.60:

@line 413,1		delay();			//keydebouncing delay

.loc 1 413 1
	bl	delay

@line 414,0		IO1CLR=0x000f0000;

.loc 1 414 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+12
	str	R5, [R4]

@line 416,1		a=P1 & 0x00f00000;

.loc 1 416 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 417,4		if(a!=0x00f00000){

.loc 1 417 4
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.55

@line 417,18	
.loc 1 417 18

@line 419,2			goto check1;

.loc 1 419 2

@line 422,2			goto up;

.loc 1 422 2
L.63:

@line 426,0		IO1CLR=0x00010000;		//row_0 set to 0

.loc 1 426 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+28
	str	R5, [R4]

@line 427,0		IO1SET=0x000e0000;

.loc 1 427 0
	ldr	R4, LIT.keybord0+16
	ldr	R5, LIT.keybord0+32
	str	R5, [R4]

@line 429,1		a=P1 & 0x00f00000;

.loc 1 429 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 430,5		 if(a!=0x00f00000)

.loc 1 430 5
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.64

@line 431,1		{

.loc 1 431 1

@line 433,2			goto row_0;

.loc 1 433 2
	b	L.66
L.64:

@line 440,0		IO1CLR=0x00020000;		//row_1 set to 0

.loc 1 440 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+36
	str	R5, [R4]

@line 441,0		IO1SET=0x000d0000;

.loc 1 441 0
	ldr	R4, LIT.keybord0+16
	ldr	R5, LIT.keybord0+40
	str	R5, [R4]

@line 443,1		a=P1 & 0x00f00000;

.loc 1 443 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 444,5		 if(a!=0x00f00000)

.loc 1 444 5
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.67

@line 445,1		{

.loc 1 445 1

@line 447,2			goto row_1;

.loc 1 447 2
	b	L.69
L.67:

@line 452,0		IO1CLR=0x00040000;		//row_2 set to 0

.loc 1 452 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+44
	str	R5, [R4]

@line 453,0		IO1SET=0x000b0000;

.loc 1 453 0
	ldr	R4, LIT.keybord0+16
	ldr	R5, LIT.keybord0+48
	str	R5, [R4]

@line 455,1		a=P1 & 0x00f00000;

.loc 1 455 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 456,5		 if(a!=0x00f00000)

.loc 1 456 5
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.70

@line 457,1		{

.loc 1 457 1

@line 459,2			goto row_2;

.loc 1 459 2
	b	L.72
L.70:

@line 464,0		IO1CLR=0x00080000;		//row_3 set to 0

.loc 1 464 0
	ldr	R4, LIT.keybord0+24
	ldr	R5, LIT.keybord0+52
	str	R5, [R4]

@line 465,0		IO1SET=0x00070000;

.loc 1 465 0
	ldr	R4, LIT.keybord0+16
	ldr	R5, LIT.keybord0+56
	str	R5, [R4]

@line 467,1		a=P1 & 0x00f00000;

.loc 1 467 1
	ldr	R4, LIT.keybord0+0
	ldr	R4,[R4]
	ldr	R5, LIT.keybord0+20
	and R4, R4, R5
	str	R4, [R11, #-4]

@line 468,5		 if(a!=0x00f00000)

.loc 1 468 5
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+20
	cmp	R4,R5
	beq	L.55

@line 469,1		{

.loc 1 469 1

@line 471,2			goto row_3;

.loc 1 471 2
	b	L.75

@line 476,1		goto up;

.loc 1 476 1
L.66:

@line 479,2			b=0;

.loc 1 479 2
	mov	R4, #0

	str	R4, [R11, #-8]

@line 480,4	  		goto down;

.loc 1 480 4
	b	L.76
L.69:

@line 482,2			b=4;

.loc 1 482 2
	mov	R4, #4

	str	R4, [R11, #-8]

@line 483,4	  		goto down;

.loc 1 483 4
	b	L.76
L.72:

@line 485,2			b=8;

.loc 1 485 2
	mov	R4, #8

	str	R4, [R11, #-8]

@line 486,4	  		goto down;

.loc 1 486 4
	b	L.76
L.75:

@line 488,2			b=12;

.loc 1 488 2
	mov	R4, #12

	str	R4, [R11, #-8]
L.76:

@line 493,4		if(a==0x00e00000)

.loc 1 493 4
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+60
	cmp	R4,R5
	bne	L.77

@line 494,1		{

.loc 1 494 1

@line 496,2			b=b+3;

.loc 1 496 2
	ldr	R4,[R11, #-8]
	add	R4, R4, #3
	str	R4, [R11, #-8]

@line 498,2			}

.loc 1 498 2
	b	L.78
L.77:

@line 499,9		else if(a==0x00d00000)

.loc 1 499 9
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+64
	cmp	R4,R5
	bne	L.79

@line 500,1		{

.loc 1 500 1

@line 502,2			b=b+2;

.loc 1 502 2
	ldr	R4,[R11, #-8]
	add	R4, R4, #2
	str	R4, [R11, #-8]

@line 504,2			}

.loc 1 504 2
	b	L.80
L.79:

@line 505,9		else if(a==0x00b00000)

.loc 1 505 9
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+68
	cmp	R4,R5
	bne	L.81

@line 506,1		{

.loc 1 506 1

@line 508,2			b=b+1;

.loc 1 508 2
	ldr	R4,[R11, #-8]
	add	R4, R4, #1
	str	R4, [R11, #-8]

@line 510,2			}

.loc 1 510 2
	b	L.82
L.81:

@line 511,9		else if(a==0x00700000)

.loc 1 511 9
	ldr	R4,[R11, #-4]
	ldr	R5, LIT.keybord0+72
	cmp	R4,R5
	bne	L.55

@line 512,1		{

.loc 1 512 1

@line 514,2			b=b;	

.loc 1 514 2
	ldr	R4,[R11, #-8]
	str	R4, [R11, #-8]

@line 516,2			}

.loc 1 516 2

@line 517,6		else goto up;	

.loc 1 517 6
L.84:
L.82:
L.80:
L.78:

@line 523,7		return(b);

.loc 1 523 7
	ldr	R0,[R11, #-8]
L.54:
	ldmfd	R11, {R4, R5, R6, R11, sp, pc}

	.p2align 2
LIT.keybord0:
	.word 0xE0028010
	.word 0xE002C014
	.word 0xE0028018
	.word 0xF0000
	.word 0xE0028014
	.word 0xF00000
	.word 0xE002801C
	.word 0x10000
	.word 0xE0000
	.word 0x20000
	.word 0xD0000
	.word 0x40000
	.word 0xB0000
	.word 0x80000
	.word 0x70000
	.word 0xE00000
	.word 0xD00000
	.word 0xB00000
	.word 0x700000



	.global delay
	@------------- locals ---------------------
	@aa -- R11 - (8)
	@bb -- R11 - (4)

	.p2align 2

	.text
delay:
	mov	R12, sp
	stmfd	sp!, {R4, R5, R11, R12, lr}
	mov R11,R13
	sub	sp, sp, #2 * 4

@line 529,0	{

.loc 1 529 0

@line 531,4	for(aa=0;aa<100;aa++)

.loc 1 531 4
	mov	R4, #0

	str	R4, [R11, #-8]
L.86:

@line 532,1		{

.loc 1 532 1

@line 533,5		for(bb=0;bb<100;bb++)

.loc 1 533 5
	mov	R4, #0

	str	R4, [R11, #-4]
L.90:

@line 534,2			{

.loc 1 534 2

@line 535,2			}

.loc 1 535 2
L.91:

@line 533,17	
.loc 1 533 17
	ldr	R4,[R11, #-4]
	add	R4, R4, #1
	str	R4, [R11, #-4]

@line 533,10	
.loc 1 533 10
	ldr	R4,[R11, #-4]
	mov	R5, #100

	cmp	R4,R5
	blt	L.90

@line 536,0	}

.loc 1 536 0
L.87:

@line 531,16	
.loc 1 531 16
	ldr	R4,[R11, #-8]
	add	R4, R4, #1
	str	R4, [R11, #-8]

@line 531,9	
.loc 1 531 9
	ldr	R4,[R11, #-8]
	mov	R5, #100

	cmp	R4,R5
	blt	L.86

@line 537,7	return 0;

.loc 1 537 7
	mov	R0, #0

L.85:
	ldmfd	R11, {R4, R5, R11, sp, pc}

	.p2align 2

	.extern b 1
