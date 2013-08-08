translation
declareCVarsIn: cg

	"Additional declarations are done in my subclasses. This permits a meaningful
	module identification string to be written with the name of the actual subclass
	being generated."

	cg addHeaderFile: '"FilePlugin.h"'.
	cg addHeaderFile: '"SocketPlugin.h"'.
	cg addHeaderFile: '"config.h"
#ifndef SQAIO_H
# define SQAIO_H "sqaio.h"  /* aio.h has been renamed to sqaio.h */
#endif
#define SESSIONIDENTIFIERTYPE int'.	"Data type for sessionID, should generate compiler warnings
									if someone changes the data type elsewhere in the VM."
.
	cg addHeaderFile: 'SQAIO_H'.
