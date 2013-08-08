translation
declareCVarsIn: aCCodeGenerator

	aCCodeGenerator
		addHeaderFile:'<stddef.h> /* for e.g. alloca */';
		addHeaderFile:'<setjmp.h>';
		addHeaderFile:'"vmCallback.h"';
		addHeaderFile:'"dispdbg.h"'.
	aCCodeGenerator 
		var: #interpreterProxy 
		type: #'struct VirtualMachine*'.
	aCCodeGenerator
		declareVar: #sendTrace type: 'volatile int';
		declareVar: #byteCount type: 'unsigned long'.
	aCCodeGenerator
		var: #primitiveTable
		declareC: 'void *primitiveTable[', (MaxPrimitiveIndex +2) printString, '] = ',	self primitiveTableString.
	aCCodeGenerator
		var: #primitiveFunctionPointer
		declareC: 'void (*primitiveFunctionPointer)()'.
	aCCodeGenerator
		var: #methodCache
		declareC: 'long methodCache[', (MethodCacheSize + 1) printString, ']'.
	aCCodeGenerator
		var: #atCache
		declareC: 'sqInt atCache[', (AtCacheTotalSize + 1) printString, ']'.
	aCCodeGenerator var: #localIP type: #'char*'.
	aCCodeGenerator var: #localSP type: #'char*'.
	aCCodeGenerator var: #showSurfaceFn type: #'void*'.
	"Newspeak as of mid 2011 derives SystemScope systemName from the interpreterVersion (via system attribute 1004)
	 by copying up to but not including the last space, provided the string ends with a digit.  So spaces must be eliminated
	 from the Monitcello version string, and we can't surround it with square brackets.."
	(aCCodeGenerator shortMonticelloDescriptionForClass: self) last isDigit ifFalse:
		[self error: 'Newspeak expects interpreterVersion ends with a digit'].
	aCCodeGenerator
		var: #interpreterVersion
		declareC: 'const char *interpreterVersion = "Newspeak Virtual Machine ',
						((aCCodeGenerator shortMonticelloDescriptionForClass: self) copyReplaceAll: ' ' with: '_'),
						'"'.
	aCCodeGenerator
		var: #externalPrimitiveTable
		declareC: 'void *externalPrimitiveTable[', (MaxExternalPrimitiveTableSize + 1) printString, ']'.

	aCCodeGenerator
		var: #imageFormatVersionNumber
		declareC: 'sqInt imageFormatVersionNumber = ',
					(BytesPerWord == 4
						ifTrue: ['6502']
						ifFalse: ['68000']).
	aCCodeGenerator
		var: #breakSelector type: #'char *';
		var: #breakSelectorLength
		declareC: 'sqInt breakSelectorLength = -1';
		var: #primTraceLogIndex type: #'unsigned char';
		var: #primTraceLog declareC: 'sqInt primTraceLog[256]';
		var: #sendTraceLogIndex type: #'unsigned char';
		var: #sendTraceLog declareC: 'sqInt sendTraceLog[256]'
