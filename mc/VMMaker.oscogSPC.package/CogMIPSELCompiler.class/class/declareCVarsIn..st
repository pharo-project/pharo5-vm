translation
declareCVarsIn: aCCodeGenerator
	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator addHeaderFile: '<asm/cachectl.h>'. "For cacheflush"