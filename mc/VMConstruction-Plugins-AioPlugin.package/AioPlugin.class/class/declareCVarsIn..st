translation
declareCVarsIn: cg

	"Additional declarations are done in my subclasses. This permits a meaningful
	module identification string to be written with the name of the actual subclass
	being generated."

	cg addHeaderFile: '"FilePlugin.h"'.
	cg addHeaderFile: '"SocketPlugin.h"'.
	cg addHeaderFile: '"config.h"
#define SESSIONIDENTIFIERTYPE int'.	"Data type for sessionID, should generate compiler warnings
									if someone changes the data type elsewhere in the VM."
	cg addHeaderFile: '"sqaio.h"'.
