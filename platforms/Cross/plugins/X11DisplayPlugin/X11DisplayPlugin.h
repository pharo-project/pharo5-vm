#ifndef _X11_DISPLAY_PLUGIN_H
#define _X11_DISPLAY_PLUGIN_H

#include "sqVirtualMachine.h"


extern void setInputSemaphoreIndexCurrentDisplay(int semaIndex, size_t d);

extern void ioDisplayFormX11(struct VirtualMachine* interpreterProxy);

#endif /*_X11_DISPLAY_PLUGIN_H*/
