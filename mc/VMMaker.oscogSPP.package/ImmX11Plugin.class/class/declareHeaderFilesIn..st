as yet unclassified
declareHeaderFilesIn: cg

	cg addHeaderFile: '<locale.h>'.
	cg addHeaderFile: '"sqUnixMain.h"'.
	cg addHeaderFile: '"sqUnixCharConv.h"', Character cr asString,
		'extern char *setLocale(char *, size_t);', Character cr asString,
		'extern int setCompositionWindowPosition(int, int);', Character cr asString,
		'extern int setCompostionFocus(int);'.