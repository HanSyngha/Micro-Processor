
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
             .global __stack

;------------------------------------------------
;			switch initializition
;------------------------------------------------
__stack:
UART_Init:

		mov r0, #GPIO_BASE	;UART
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #0x618
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1
		str r0, [r1]

		mov r0, #GPIO_BASE	;UART-GPIO
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #0x608
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1
		str r0, [r1]

		mov r0, #GPIO_BASE	;Disable UART
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x030
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1
		str r0, [r1]

		mov r0, #GPIO_BASE	;UART-IBRD
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x024
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0xFF
		orr r0, r0, #8
		str r0, [r1]

		mov r0, #GPIO_BASE	;UART-FBRD
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x028
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0xFF
		orr r0, r0, #44
		str r0, [r1]

		mov r0, #GPIO_BASE	;UART-LCRD
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x02C
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0xFF
		orr r0, r0, #0x60
		str r0, [r1]

		mov r0, #GPIO_BASE	;Enable UART
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x030
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x300
		orr r0, r0, #0x1
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL UART
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x03
		str r0, [r1]

		mov r0, #GPIO_BASE	;GPIOPCTL UART
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #0x52C
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x11
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN_UART
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x03
		str r0, [r1]

		mov r0, #GPIO_BASE	;AMSEL_UART : Disable
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		mov r0, #0
		str r0, [r1]

		mov r0, #GPIO_BASE	;UARTFR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x018
		add r1, r1, r0

		mov r0, #0x60
		str r0, [r1]


LED_Init:

		mov r0, #GPIO_BASE	;RCGC2 : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
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

Switch_Init:

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

UART_LED:

		mov r0, #GPIO_BASE	;UARTDR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x000
		add r1, r1, r0

		ldr r0,[r1]
		mov r0,#0
		orr r0,#'L'
		str r0, [r1]
DELAY1:	MOVW r3,#0xffff

_DELAY_LOOP1:
		CBZ r3,_DELAY_EXIT1		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP1
_DELAY_EXIT1:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'E'
		str r0, [r1]
DELAY2:	MOVW r3,#0xffff

_DELAY_LOOP2:
		CBZ r3,_DELAY_EXIT2		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP2
_DELAY_EXIT2:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'D'
		str r0, [r1]

DELAY3:	MOVW r3,#0xffff

_DELAY_LOOP3:
		CBZ r3,_DELAY_EXIT3	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP3
_DELAY_EXIT3:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#' '
		str r0, [r1]

DELAY4:	MOVW r3,#0xffff

_DELAY_LOOP4:
		CBZ r3,_DELAY_EXIT4	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP4
_DELAY_EXIT4:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'M'
		str r0, [r1]

DELAY5:	MOVW r4,#0xffff

_DELAY_LOOP5:
		CBZ r3,_DELAY_EXIT5	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP5
_DELAY_EXIT5:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'O'
		str r0, [r1]

DELAY6:	MOVW r3,#0xffff

_DELAY_LOOP6:
		CBZ r3,_DELAY_EXIT6	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP6
_DELAY_EXIT6:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'D'
		str r0, [r1]

DELAY7:	MOVW r3,#0xffff

_DELAY_LOOP7:
		CBZ r3,_DELAY_EXIT7	;Compare and Branch on Zer
		sub r3,r3,#1
		B _DELAY_LOOP7
_DELAY_EXIT7:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'E'
		str r0, [r1]

DELAY8:	MOVW r3,#0xffff

_DELAY_LOOP8:
		CBZ r3,_DELAY_EXIT8	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP8
_DELAY_EXIT8:
		ldr r0,[r1]
		mov r0,#0x0A
		orr r0,#0x0
		str r0, [r1]
DELAY9:	MOVW r3,#0xffff

_DELAY_LOOP9:
		CBZ r3,_DELAY_EXIT9	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP9
_DELAY_EXIT9:
		ldr r0,[r1]
		mov r0,#0x0D
		orr r0,#0x0
		str r0, [r1]

Switch_Input:

		mov r5, #GPIO_BASE
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]

DELAY:	MOVW r3,#0xffff
		mov r3,r3,lsl#2

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
		mov r0, #GPIO_BASE	;UARTDR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x000
		add r1, r1, r0

		ldr r0,[r1]
		mov r0,#0
		orr r0,#'-'
		str r0, [r1]
DELAYA1: MOVW r3,#0xffff

_DELAY_LOOPA1:
		CBZ r3,_DELAY_EXITA1		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA1
_DELAY_EXITA1:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'S'
		str r0, [r1]
DELAYA2: MOVW r3,#0xffff

_DELAY_LOOPA2:
		CBZ r3,_DELAY_EXITA2		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA2
_DELAY_EXITA2:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'W'
		str r0, [r1]
DELAYA3: MOVW r3,#0xffff

_DELAY_LOOPA3:
		CBZ r3,_DELAY_EXITA3	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA3
_DELAY_EXITA3:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#' '
		str r0, [r1]
DELAYA4: MOVW r3,#0xffff

_DELAY_LOOPA4:
		CBZ r3,_DELAY_EXITA4	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA4
_DELAY_EXITA4:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'A'
		str r0, [r1]
DELAYA5: MOVW r3,#0xffff

_DELAY_LOOPA5:
		CBZ r3,_DELAY_EXITA5	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA5
_DELAY_EXITA5:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#0x0A
		str r0, [r1]
DELAYA6: MOVW r3,#0xffff

_DELAY_LOOPA6:
		CBZ r3,_DELAY_EXITA6	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPA6
_DELAY_EXITA6:
		ldr r0,[r1]
		mov r0,#0x0D
		orr r0,#0x0
		str r0, [r1]

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
		mov r0, #GPIO_BASE	;UARTDR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x000
		add r1, r1, r0

		ldr r0,[r1]
		mov r0,#0
		orr r0,#'-'
		str r0, [r1]
DELAYB1: MOVW r3,#0xffff

_DELAY_LOOPB1:
		CBZ r3,_DELAY_EXITB1		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB1
_DELAY_EXITB1:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'S'
		str r0, [r1]
DELAYB2: MOVW r3,#0xffff

_DELAY_LOOPB2:
		CBZ r3,_DELAY_EXITB2		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB2
_DELAY_EXITB2:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'W'
		str r0, [r1]
DELAYB3: MOVW r3,#0xffff

_DELAY_LOOPB3:
		CBZ r3,_DELAY_EXITB3	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB3
_DELAY_EXITB3:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#' '
		str r0, [r1]
DELAYB4: MOVW r3,#0xffff

_DELAY_LOOPB4:
		CBZ r3,_DELAY_EXITB4	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB4
_DELAY_EXITB4:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'B'
		str r0, [r1]
DELAYB5: MOVW r3,#0xffff

_DELAY_LOOPB5:
		CBZ r3,_DELAY_EXITB5	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB5
_DELAY_EXITB5:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#0x0A
		str r0, [r1]
DELAYB6: MOVW r3,#0xffff

_DELAY_LOOPB6:
		CBZ r3,_DELAY_EXITB6	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPB6
_DELAY_EXITB6:
		ldr r0,[r1]
		mov r0,#0x0D
		orr r0,#0x0
		str r0, [r1]

		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r2, #0x00
		str r2, [r1]
		b _EXIT

_slow:
		mov r0, #GPIO_BASE	;UARTDR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x000
		add r1, r1, r0

		ldr r0,[r1]
		mov r0,#0
		orr r0,#'-'
		str r0, [r1]
DELAYC1: MOVW r3,#0xffff

_DELAY_LOOPC1:
		CBZ r3,_DELAY_EXITC1		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC1
_DELAY_EXITC1:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'S'
		str r0, [r1]
DELAYC2: MOVW r3,#0xffff

_DELAY_LOOPC2:
		CBZ r3,_DELAY_EXITC2		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC2
_DELAY_EXITC2:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'W'
		str r0, [r1]
DELAYC3: MOVW r3,#0xffff

_DELAY_LOOPC3:
		CBZ r3,_DELAY_EXITC3	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC3
_DELAY_EXITC3:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#' '
		str r0, [r1]
DELAYC4: MOVW r3,#0xffff

_DELAY_LOOPC4:
		CBZ r3,_DELAY_EXITC4	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC4
_DELAY_EXITC4:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'C'
		str r0, [r1]
DELAYC5: MOVW r3,#0xffff

_DELAY_LOOPC5:
		CBZ r3,_DELAY_EXITC5	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC5
_DELAY_EXITC5:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#0x0A
		str r0, [r1]
DELAYC6: MOVW r3,#0xffff

_DELAY_LOOPC6:
		CBZ r3,_DELAY_EXITC6	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPC6
_DELAY_EXITC6:
		ldr r0,[r1]
		mov r0,#0x0D
		orr r0,#0x0
		str r0, [r1]

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
		MOV r3,r3,LSL#5

_sDELAY_LOOP0:
		CBZ r3,_sDELAY0_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP0
_sDELAY0_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY1:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP1:
		CBZ r3,_sDELAY1_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP1
_sDELAY1_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;2
sDELAY2:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP2:
		CBZ r3,_sDELAY2_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP2
_sDELAY2_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY3:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP3:
		CBZ r3,_sDELAY3_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP3
_sDELAY3_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;3
sDELAY4:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP4:
		CBZ r3,_sDELAY4_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP4
_sDELAY4_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY5:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP5:
		CBZ r3,_sDELAY5_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP5
_sDELAY5_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;4
sDELAY6:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP6:
		CBZ r3,_sDELAY6_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP6
_sDELAY6_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY7:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP7:
		CBZ r3,_sDELAY7_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP7
_sDELAY7_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;5
sDELAY8:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP8:
		CBZ r3,_sDELAY8_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP8
_sDELAY8_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

sDELAY9:	MOVW r3,#0xffff
		MOV r3,r3,LSL#5

_sDELAY_LOOP9:
		CBZ r3,_sDELAY9_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _sDELAY_LOOP9
_sDELAY9_EXIT:
		mov r2, #0x00
		str r2, [r1]
		b _EXIT


_fast:
		mov r0, #GPIO_BASE	;UARTDR
		mov r1, #0xC000
		add r1, r1, r0
		mov r0, #0x000
		add r1, r1, r0

		ldr r0,[r1]
		mov r0,#0
		orr r0,#'-'
		str r0, [r1]
DELAYD1: MOVW r3,#0xffff

_DELAY_LOOPD1:
		CBZ r3,_DELAY_EXITD1		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD1
_DELAY_EXITD1:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'S'
		str r0, [r1]
DELAYD2: MOVW r3,#0xffff

_DELAY_LOOPD2:
		CBZ r3,_DELAY_EXITD2		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD2
_DELAY_EXITD2:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'W'
		str r0, [r1]
DELAYD3: MOVW r3,#0xffff

_DELAY_LOOPD3:
		CBZ r3,_DELAY_EXITD3	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD3
_DELAY_EXITD3:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#' '
		str r0, [r1]
DELAYD4: MOVW r3,#0xffff

_DELAY_LOOPD4:
		CBZ r3,_DELAY_EXITD4	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD4
_DELAY_EXITD4:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#'D'
		str r0, [r1]
DELAYD5: MOVW r3,#0xffff

_DELAY_LOOPD5:
		CBZ r3,_DELAY_EXITD5	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD5
_DELAY_EXITD5:
		ldr r0,[r1]
		mov r0,#0
		orr r0,#0x0A
		str r0, [r1]
DELAYD6: MOVW r3,#0xffff

_DELAY_LOOPD6:
		CBZ r3,_DELAY_EXITD6	;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOPD6
_DELAY_EXITD6:
		ldr r0,[r1]
		mov r0,#0x0D
		orr r0,#0x0
		str r0, [r1]

		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		mov r2, #0x00
		str r2, [r1]
;;1
fDELAY0:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP0:
		CBZ r3,_fDELAY0_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP0
_fDELAY0_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY1:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP1:
		CBZ r3,_fDELAY1_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP1
_fDELAY1_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;2
fDELAY2:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP2:
		CBZ r3,_fDELAY2_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP2
_fDELAY2_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY3:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP3:
		CBZ r3,_fDELAY3_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP3
_fDELAY3_EXIT:
		mov r2, #0x00
		str r2, [r1]
;;3
fDELAY4:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP4:
		CBZ r3,_fDELAY4_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP4
_fDELAY4_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY5:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP5:
		CBZ r3,_fDELAY5_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP5
_fDELAY5_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;4
fDELAY6:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP6:
		CBZ r3,_fDELAY6_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP6
_fDELAY6_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY7:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP7:
		CBZ r3,_fDELAY7_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP7
_fDELAY7_EXIT:
		mov r2, #0x00
		str r2, [r1]

;;5
fDELAY8:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP8:
		CBZ r3,_fDELAY8_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP8
_fDELAY8_EXIT:
		ldr r2, [r1]
		orr r2, r2, #0x04
		str r2, [r1]

fDELAY9:	MOVW r3,#0xffff
		MOV r3,r3,LSL#3

_fDELAY_LOOP9:
		CBZ r3,_fDELAY9_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _fDELAY_LOOP9
_fDELAY9_EXIT:
		mov r2, #0x00
		str r2, [r1]

		b _EXIT

_EXIT:
		b Switch_Input

			.retain
			.retainrefs
