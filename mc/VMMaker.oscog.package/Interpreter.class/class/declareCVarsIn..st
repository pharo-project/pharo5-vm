translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator addHeaderFile:'<setjmp.h>'.
	self declareInterpreterVersionIn: aCCodeGenerator
		defaultName: 'Context'.
	aCCodeGenerator 
		var: #interpreterProxy 
		type: #'struct VirtualMachine*'.
	aCCodeGenerator
		var: #primitiveTable
		declareC: 'void *primitiveTable[MaxPrimitiveIndex + 2 /* ', (MaxPrimitiveIndex +2) printString, ' */] = ',	self primitiveTableString.
	aCCodeGenerator
		var: #primitiveFunctionPointer
		declareC: 'void *primitiveFunctionPointer'.	"xxxx FIX THIS STUPIDITY xxxx - ikp. What he means is use a better type than void *, apparently - tpr"
	aCCodeGenerator
		var: #methodCache
		declareC: 'sqIntptr_t methodCache[MethodCacheSize + 1 /* ', (MethodCacheSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #atCache
		declareC: 'sqInt atCache[AtCacheTotalSize + 1 /* ', (AtCacheTotalSize + 1) printString, ' */]'.
	aCCodeGenerator var: #localIP type: #'char*'.
	aCCodeGenerator var: #localSP type: #'char*'.
	aCCodeGenerator var: #showSurfaceFn type: #'void*'.
	aCCodeGenerator var: 'semaphoresToSignalA'
		declareC: 'sqInt semaphoresToSignalA[SemaphoresToSignalSize + 1 /* ', (SemaphoresToSignalSize + 1) printString, ' */]'.
	aCCodeGenerator var: 'semaphoresToSignalB'
		declareC: 'sqInt semaphoresToSignalB[SemaphoresToSignalSize + 1 /* ', (SemaphoresToSignalSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #compilerHooks
		declareC: 'sqInt (*compilerHooks[CompilerHooksSize + 1 /* ', (CompilerHooksSize + 1) printString, ' */])()'.
	aCCodeGenerator
		var: #externalPrimitiveTable
		declareC: 'void *externalPrimitiveTable[MaxExternalPrimitiveTableSize + 1 /* ', (MaxExternalPrimitiveTableSize + 1) printString, ' */]'.

	aCCodeGenerator
		var: #jmpBuf
		declareC: 'jmp_buf jmpBuf[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.
	aCCodeGenerator
		var: #suspendedCallbacks
		declareC: 'usqInt suspendedCallbacks[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.
	aCCodeGenerator
		var: #suspendedMethods
		declareC: 'usqInt suspendedMethods[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.

	self declareCAsOop: {
		#instructionPointer. 
		#method. 
		#newMethod. 
		#activeContext. 
		#theHomeContext. 
		#stackPointer
	} in: aCCodeGenerator.

	aCCodeGenerator var: #nextProfileTick type: #sqLong.
