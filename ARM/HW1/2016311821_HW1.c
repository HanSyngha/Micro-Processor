//*****************************************************************************
//
// hello.c - Simple hello world example.
//
// Copyright (c) 2011-2013 Texas Instruments Incorporated.  All rights reserved.
// Software License Agreement
//
// Texas Instruments (TI) is supplying this software for use solely and
// exclusively on TI's microcontroller products. The software is owned by
// TI and/or its suppliers, and is protected under applicable copyright
// laws. You may not combine this software with "viral" open-source
// software in order to form a larger program.
//
// THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
// NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
// NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITarr[0]S FOR
// A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
// CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
// DAMAGES, FOR ANY REASON WHATSOEVER.
//
// This is part of revision 1.1 of the DK-TM4C123G Firmware Package.
//
//*****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "driverlib/fpu.h"
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/pin_map.h"
#include "driverlib/uart.h"
#include "grlib/grlib.h"
#include "drivers/cfal96x64x16.h"
#include "utils/uartstdio.h"
#include "driverlib/gpio.h"



extern unsigned int num_1();
extern unsigned int num_3();
extern unsigned int Switch_Input();
extern unsigned int Switch_Init();
int num1 = 0;
tRectangle fRect4;
tRectangle fRect3;
tRectangle fRect2;
tRectangle fRect1;
//extern void ConfigureUART(void);
//*****************************************************************************
//
//! \addtogroup example_list
//! <h1>Hello World (hello)</h1>
//!
//! A very simple ``hello world'' example.  It simply displays ``Hello World!''
//! on the display and is a starting 0 for more complicated applications.
//! This example uses calls to the TivaWare Graphics Library graphics
//! primitives functions to update the display.  For a similar example using
//! widgets, please see ``hello_widget''.
//
//*****************************************************************************

//*****************************************************************************
//
// The error routine that is called if the driver library encounters an error.
//
//*****************************************************************************
#ifdef DEBUG
void
__error__(char *pcFilename, uint32_t ui32Line)
{
}
#endif

//*****************************************************************************
//
// Configure the UART and its pins.  This must be called before UARTprintf().
//
//*****************************************************************************
void
ConfigureUART(void)
{
    //
    // Enable the GPIO Peripheral used by the UART.
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);

    //
    // Enable UART0
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);

    //
    // Configure GPIO Pins for UART mode.
    //
    ROM_GPIOPinConfigure(GPIO_PA0_U0RX);
    ROM_GPIOPinConfigure(GPIO_PA1_U0TX);
    ROM_GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    //
    // Use the internal 16MHz oscillator as the UART clock source.
    //
    UARTClockSourceSet(UART0_BASE, UART_CLOCK_PIOSC);

    //
    // Initialize the UART for console I/O.
    //
    UARTStdioConfig(0, 115200, 16000000);
}

void resetbyE(char n[],int *num){
	int i;
	for (i=0;i<4;i++){
		n[i] = '0';
	}
	*num = 0;
}

void Draw(char n[],tContext *sContext,tRectangle tRect0){
		  fRect1.i16XMin = 10;
		  fRect1.i16XMax = 10+8*(n[0]-'0');
		  fRect1.i16YMin = 10;
		  fRect1.i16YMax = 18;

		  fRect2.i16XMin = 10;
		  fRect2.i16XMax = 10+8*(n[1]-'0');
		  fRect2.i16YMin = 18;
		  fRect2.i16YMax = 26;

		  fRect3.i16XMin = 10;
		  fRect3.i16XMax = 10+8*(n[2]-'0');
		  fRect3.i16YMin = 26;
		  fRect3.i16YMax = 34;

		  fRect4.i16XMin = 10;
		  fRect4.i16XMax = 10+8*(n[3]-'0');
		  fRect4.i16YMin = 34;
		  fRect4.i16YMax = 42;
}

void makeblack(tContext *sContext,tRectangle tRect0){
	 DpyRectFill(sContext->psDisplay, &tRect0, 0);
}
//*****************************************************************************
//
// Print "Hello World!" to the display.
//
//*****************************************************************************
int
main(void)
{
	//led();
    tContext sContext;
    ROM_FPULazyStackingEnable();
    ROM_SysCtlClockSet(SYSCTL_SYSDIV_4 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ |
                       SYSCTL_OSC_MAIN);
    ConfigureUART();

    UARTprintf("Hello, world!\n");

    CFAL96x64x16Init();

    GrContextInit(&sContext, &g_sCFAL96x64x16);

    GrContextForegroundSet(&sContext, ClrWhite);

    GrContextFontSet(&sContext, g_psFontCm12);

//*****************************************************************************************
//*****************************************************************************************

    	char n[4] = {'0', '0', '0', '0'};
    	tRectangle tRect0;
    	tRect0.i16XMin = 0;
    	tRect0.i16XMax = 95;
    	tRect0.i16YMin = 0;
    	tRect0.i16YMax = 61;

    	tRectangle tRect4;
    	tRect4.i16XMin = 10;
    	tRect4.i16XMax = 82;
    	tRect4.i16YMin = 10;
    	tRect4.i16YMax = 18;

    	tRectangle tRect3;
    	tRect3.i16XMin = 10;
    	tRect3.i16XMax = 82;
    	tRect3.i16YMin = 18;
    	tRect3.i16YMax = 26;

    	tRectangle tRect2;
    	tRect2.i16XMin = 10;
    	tRect2.i16XMax = 82;
    	tRect2.i16YMin = 26;
    	tRect2.i16YMax = 34;

    	tRectangle tRect1;
    	tRect1.i16XMin = 10;
    	tRect1.i16XMax = 82;
    	tRect1.i16YMin = 34;
    	tRect1.i16YMax = 42;



        Switch_Init();
while(1){

	  Switch_Input();
	  if(num_1() == 'E'){
		  makeblack(&sContext,tRect0);
		  resetbyE(n,&num1);
	  	  }
	  if(num_1() == 'D'){
		  makeblack(&sContext,tRect0);
		  num1++;
		  if(num1>3){
			  num1 --;
		  }
	  }
	  if(num_1() == 'C'){
		  makeblack(&sContext,tRect0);
		  num1--;
		  if(num1 <0){
			  num1++;
		  }
	  }
	  if(num_1() == 'A'){
		  makeblack(&sContext,tRect0);
		  n[num1]++;
		  if(n[num1] > '9'){
			  n[num1] = '0';
		  }
	  }
	  if(num_1() == 'B'){
		  makeblack(&sContext,tRect0);
		  n[num1]--;
		  if(n[num1] < '0'){
			  n[num1] = '9';
		  }
	  }
	  Draw(n,&sContext,tRect0);


	 GrRectDraw(&sContext, &tRect4);
	 GrRectDraw(&sContext, &tRect3);
	 GrRectDraw(&sContext, &tRect2);
	 GrRectDraw(&sContext, &tRect1);

	 GrRectFill(&sContext, &fRect1);
	 GrRectFill(&sContext, &fRect2);
	 GrRectFill(&sContext, &fRect3);
	 GrRectFill(&sContext, &fRect4);
	 GrStringDrawCentered(&sContext, n, 4, GrContextDpyWidthGet(&sContext) / 2, 52, 1);

}	//end while
//*****************************************************************************************
//*****************************************************************************************
//    GrFlush(&sContext);
}
//end main


