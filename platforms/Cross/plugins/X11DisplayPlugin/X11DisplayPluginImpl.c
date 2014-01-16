#include "X11DisplayPlugin.h"
#include <X11/Xlib.h>

extern struct VirtualMachine* interpreterProxy;

static int inputSemaphoreIndex = 0;
static Display * current_display = 0;

void ioCheckForEvents() {

	if (current_display && XPending(current_display)) {
		interpreterProxy->signalSemaphoreWithIndex(inputSemaphoreIndex);
	}
}

void setInputSemaphoreIndexCurrentDisplay(int semaIndex, size_t d) {
    current_display = (Display*)d;
    inputSemaphoreIndex = semaIndex;
    setIoProcessEventsHandler(&ioCheckForEvents);
}



/*
displayForm: aForm 
display: d 
window: awindow
srcX: srcX 
srcY: srcY 
dstX: dstX 
dstY: dstY 
w: w 
h: h
*/
void ioDisplayFormX11(struct VirtualMachine* interpreterProxy)
{
    
    if (interpreterProxy->argumentCountOf(interpreterProxy->primitiveMethod()) != 9) {
        interpreterProxy->primitiveFail();
        return;
    }    
    int height = interpreterProxy->stackIntegerValue(0);
    int width = interpreterProxy->stackIntegerValue(1);
    int dstY = interpreterProxy->stackIntegerValue(2);
    int dstX = interpreterProxy->stackIntegerValue(3);
    int srcY = interpreterProxy->stackIntegerValue(4);
    int srcX = interpreterProxy->stackIntegerValue(5);
    Window window = (Window)interpreterProxy->stackIntegerValue(6);
    Display * display = (Display*)interpreterProxy->stackIntegerValue(7);
    sqInt formOop = interpreterProxy->stackObjectValue(8);

    if (interpreterProxy->failed()) 
        return;
// DisplayMedium subclass: #Form
//	instanceVariableNames: 'bits width height depth offset'

#define FormBitsIndex 0
#define FormWidthIndex 1
#define FormHeightIndex 2
#define FormDepthIndex 3
/*	sourceBits := interpreterProxy fetchPointer: FormBitsIndex ofObject: sourceForm.
	sourceWidth := self fetchIntOrFloat: FormWidthIndex ofObject: sourceForm.
	sourceHeight := self fetchIntOrFloat: FormHeightIndex ofObject: sourceForm.
	(sourceWidth >= 0 and: [sourceHeight >= 0])
		ifFalse: [^ false].
	sourceDepth := interpreterProxy fetchInteger: FormDepthIndex ofObject: sourceForm.
	sourceMSB := sourceDepth > 0.
	sourceDepth < 0 ifTrue:[sourceDepth := 0 - sourceDepth].
*/
    sqInt bitsOop = interpreterProxy->fetchPointerofObject(FormBitsIndex,formOop);
    int formWidth = interpreterProxy->fetchIntegerofObject(FormWidthIndex,formOop);
    int formHeight = interpreterProxy->fetchIntegerofObject(FormHeightIndex,formOop);
    int formDepth = interpreterProxy->fetchIntegerofObject(FormDepthIndex,formOop);
     
    if (!interpreterProxy->isWordsOrBytes(bitsOop)) {
        interpreterProxy->primitiveFail();
        return;
    }
    void * bitsData = interpreterProxy->firstIndexableField(bitsOop);

    XImage image;

    image.width = formWidth;
    image.height = formHeight;
    image.xoffset = 0;
    image.format = ZPixmap;
    image.data = bitsData;
    image.byte_order = ImageByteOrder(display);
    image.bitmap_unit = 32;
    image.bitmap_bit_order = BitmapBitOrder(display);
    image.bitmap_pad = 32;
    image.depth = 24;
    image.bytes_per_line = 0;
    image.bits_per_pixel = 32;
    image.red_mask = 0xFF;
    image.green_mask = 0xFF00;
    image.blue_mask = 0xFF0000;
    image.obdata = 0;

    GC gc = XDefaultGC(display, XDefaultScreen(display));

    XInitImage(&image);
    XPutImage(display, window, gc, &image, srcX, srcY, dstX, dstY, width, height);
}

