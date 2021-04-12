
	.cdecls C, LIST, "Compiler.h"
;------------------------------------------------
;		.data
;------------------------------------------------
GPIO_BASE			.equ	0x40000000
NVIC_BASE			.equ	0xe0000000
RCGCGPIO			.equ	0x608
GPIOHBCTL			.equ	0x06C
GPIODIR				.equ	0x400
GPIOAFSEL			.equ	0x420
GPIOPUR				.equ	0x510
GPIODEN				.equ	0x51C
GPIOAMSEL			.equ	0x528
GPIOPCTL			.equ	0x52C
GPIOLOCK			.equ	0x520
GPIOCR				.equ	0x524

GPIODATA			.equ	0x000
EN3					.equ	0x10C
GPIOIM				.equ	0x410
GPIOICR				.equ	0x41C

SW_ON				.equ	0x1E
SW_OFF				.equ	0x1D
SW_SLOW				.equ	0x1B
SW_FAST				.equ    0x17
;--------------------------------------------------
             .text                           ; Program Start
             .global RESET                   ; Define entry point
             .align	4
			 .sect ".text"

             .global Switch_Init
             .global Switch_Input
			 .global num_1
			 .global num_3

;------------------------------------------------
;			switch initializition
;------------------------------------------------

Switch_Init:
;LED init
		mov r0, #GPIO_BASE	;RCGC2 : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #0x108
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x40
		str r0, [r1]

		mov r0, #GPIO_BASE	;DIR_G
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x4
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL_G : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x4
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN_G
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;DR8R
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #0x508
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x04
		str r0, [r1]

		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;HBCTL : High-Performance Bus Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #GPIOHBCTL
		add r1, r1, r0

		mov r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		mov r0, #0
		str r0, [r1]

		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f;#0x000f000f
		str r0, [r1]

		mov r0, #GPIO_BASE	;LOCK
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOLOCK
		add r1, r1, r0

		mov r0, #GPIO_BASE
		mov r2, #0xc400000
		add r2, r2, r0
		mov r0, #0xf4000
		add r2, r2, r0
		mov r0, #0x34b
		add r2, r2, r0

		ldr r0, [r1]
		orr r0, r0, r2
		str r0, [r1]

		mov r0, #GPIO_BASE	;CR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOCR
		add r1, r1, r0

		ldr r0, [r1]
		mov r2, #0x00000000
		bic r0, r0, r2
		str r0, [r1]

Switch_Input:

		mov r5, #GPIO_BASE
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]

DELAY:	MOVW r3,#0xffff

_DELAY_LOOP:
		CBZ r3,_DELAY_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP
_DELAY_EXIT:

		cmp r5, #SW_ON
		BEQ _on

		cmp r5, #SW_OFF
		BEQ _off

		cmp r5, #SW_SLOW
		BEQ _slow

		cmp r5, #SW_FAST
		BEQ _fast

		mov r1, #'A'
		b _EXIT

_on:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]
		b _EXIT

_off:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r2, #0x00
		str r2, [r1]
		b _EXIT

_slow:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5
;;1
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

		mov r2, #0x00
		str r2, [r1]
;;1
sDELAY0:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP0:
		CBZ r3,_sDELAY0_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP0
_sDELAY0_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY1:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP1:
		CBZ r3,_sDELAY1_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP1
_sDELAY1_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;2
sDELAY2:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP2:
		CBZ r3,_sDELAY2_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP2
_sDELAY2_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY3:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP3:
		CBZ r3,_sDELAY3_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP3
_sDELAY3_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;3
sDELAY4:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP4:
		CBZ r3,_sDELAY4_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP4
_sDELAY4_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY5:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP5:
		CBZ r3,_sDELAY5_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP5
_sDELAY5_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;4
sDELAY6:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP6:
		CBZ r3,_sDELAY6_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP6
_sDELAY6_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY7:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP7:
		CBZ r3,_sDELAY7_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP7
_sDELAY7_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;5
sDELAY8:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP8:
		CBZ r3,_sDELAY8_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP8
_sDELAY8_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY9:	MOVW r3,#0xffff
		MOV r3,r3,LSL#7

_sDELAY_LOOP9:
		CBZ r3,_sDELAY9_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP9
_sDELAY9_EXIT:
		mov r2, #0x00
		str r2, [r1]
		b _EXIT


_fast:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r2, #0x00
		str r2, [r1]
;;1
fDELAY0:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP0:
		CBZ r3,_fDELAY0_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP0
_fDELAY0_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY1:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP1:
		CBZ r3,_fDELAY1_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP1
_fDELAY1_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;2
fDELAY2:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP2:
		CBZ r3,_fDELAY2_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP2
_fDELAY2_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY3:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP3:
		CBZ r3,_fDELAY3_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP3
_fDELAY3_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;3
fDELAY4:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP4:
		CBZ r3,_fDELAY4_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP4
_fDELAY4_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY5:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP5:
		CBZ r3,_fDELAY5_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP5
_fDELAY5_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;4
fDELAY6:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP6:
		CBZ r3,_fDELAY6_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP6
_fDELAY6_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY7:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP7:
		CBZ r3,_fDELAY7_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP7
_fDELAY7_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;5
fDELAY8:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP8:
		CBZ r3,_fDELAY8_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP8
_fDELAY8_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY9:	MOVW r3,#0xffff
		MOV r3,r3,LSL#4

_fDELAY_LOOP9:
		CBZ r3,_fDELAY9_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP9
_fDELAY9_EXIT:
		mov r2, #0x00
		str r2, [r1]

		b _EXIT

_EXIT:
		bx lr

num_1:
		mov r0, r1
		bx lr

num_3:
		mov r0, #'D'
		bx lr

			.retain
			.retainrefs
