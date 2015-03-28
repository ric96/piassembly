/* NEW
* The foreColour is the colour which all our methods will draw shapes in.
* C++ Signature: short foreColour;
*/
.section .data
.align 1
foreColour:
	.hword 0xFFFF

/* NEW
* graphicsAddress stores the address of the frame buffer info structure. 
* C++ Signature: FrameBuferDescription* graphicsAddress;
*/
.align 2
graphicsAddress:
	.int 0

/* NEW
* SetForeColour changes the current drawing colour to the 16 bit colour in r0.
* C++ Signature: void SetForeColour(u16 colour);
*/
.section .text
.globl SetForeColour
SetForeColour:
	cmp r0,#0x10000
	movhi pc,lr
	moveq pc,lr

	ldr r1,=foreColour
	strh r0,[r1]
	mov pc,lr

/* NEW
* SetGraphicsAddress changes the current frame buffer information to 
* graphicsAddress;
* C++ Signature: void SetGraphicsAddress(FrameBuferDescription* value);
*/
.globl SetGraphicsAddress
SetGraphicsAddress:
	ldr r1,=graphicsAddress
	str r0,[r1]
	mov pc,lr
	
/* NEW
* DrawPixel draws a single pixel to the screen at the point in (r0,r1).
* C++ Signature: void DrawPixel(u32x2 point);
*/
.globl DrawPixel
DrawPixel:
	px .req r0
	py .req r1
	
	addr .req r2
	ldr addr,=graphicsAddress
	ldr addr,[addr]
	
	height .req r3
	ldr height,[addr,#4]
	sub height,#1
	cmp py,height
	movhi pc,lr
	.unreq height
	
	width .req r3
