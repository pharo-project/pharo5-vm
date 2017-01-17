C code generator
emitCHeaderOn: aStream
	"Write a C file header onto the given stream."

	aStream nextPutAll: (self fileHeaderVersionStampForSourceClass: pluginClass).
	aStream cr; cr.

	#('<math.h>' '<stdio.h>' '<stdlib.h>' '<string.h>' '<time.h>') reverseDo:
		[:hdr| self addHeaderFileFirst: hdr].

	"Additional header files; include C library ones first."
	self emitHeaderFiles: (headerFiles select: [:hdr| hdr includes: $<]) on: aStream.

	aStream cr; nextPutAll:'/* Default EXPORT macro that does nothing (see comment in sq.h): */
#define EXPORT(returnType) returnType

/* Do not include the entire sq.h file but just those parts needed. */
#include "sqConfig.h"			/* Configuration options */
#include "sqVirtualMachine.h"	/*  The virtual machine proxy definition */
#include "sqPlatformSpecific.h"	/* Platform specific definitions */

#define true 1
#define false 0
#define null 0  /* using ''null'' because nil is predefined in Think C */
#ifdef SQUEAK_BUILTIN_PLUGIN
# undef EXPORT
# define EXPORT(returnType) static returnType
#endif'; cr; cr.
	self addHeaderFile: '"sqMemoryAccess.h"'.
	"Additional header files; include squeak VM ones last"
	self emitHeaderFiles: (headerFiles reject: [:hdr| hdr includes: $<]) on: aStream.
	self maybePutPreambleFor: pluginClass on: aStream.
	aStream cr