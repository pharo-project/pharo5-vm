translation
declareCVarsIn: cg

	"Additional declarations are done in my subclasses. This permits a meaningful
	module identification string to be written with the name of the actual subclass
	being generated."

	cg addHeaderFile: '<sys/types.h>'.
	cg addHeaderFile: '<windows.h>'.
	cg addHeaderFile: '<process.h>'.
	cg addHeaderFile: '"sqWin32.h"'.
	cg addConstantForBinding: 'FILEHANDLETYPE' -> 'FILE *  /* the type of low level stream to be used in a struct SQFile */'.
	cg addConstantForBinding: 'READCHARARRAYSIZE' -> '512	/* Corresponds to expected max size of external semaphore table */
									/* Table expands dynamically, so just use a big number */'.
	cg var: 'readCharArraySize' declareC: 'int readCharArraySize = READCHARARRAYSIZE'.
	cg var: 'readCharBufferArray' declareC: 'unsigned char readCharBufferArray[READCHARARRAYSIZE]'.
	cg var: 'readCharCountArray' declareC: 'DWORD readCharCountArray[READCHARARRAYSIZE]'.
	cg var: 'readCharStatusArray' declareC: 'int readCharStatusArray[READCHARARRAYSIZE]'.
	cg var: 'readCharThreadIdArray' declareC: 'DWORD readCharThreadIdArray[READCHARARRAYSIZE]'.
