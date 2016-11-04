translation
declareCVarsIn: aCCodeGenerator
	| vmClass |
	self class == thisContext methodClass ifFalse: [^self]. "Don't duplicate decls in subclasses"
	vmClass := aCCodeGenerator vmClass. "Generate primitiveTable etc based on vmClass, not just StackInterpreter"
	aCCodeGenerator
		addHeaderFile:'<stddef.h> /* for e.g. alloca */';
		addHeaderFile:'<setjmp.h>';
		addHeaderFile:'<wchar.h> /* for wint_t */';
		addHeaderFile:'"vmCallback.h"';
		addHeaderFile:'"sqMemoryFence.h"';
		addHeaderFile:'"dispdbg.h"'.
	LowcodeVM ifTrue: [ aCCodeGenerator addHeaderFile:'"sqLowcodeFFI.h"'].
	
	vmClass declareInterpreterVersionIn: aCCodeGenerator defaultName: 'Stack'.
	aCCodeGenerator
		var: #interpreterProxy  type: #'struct VirtualMachine*'.
	aCCodeGenerator
		declareVar: #sendTrace type: 'volatile int';
		declareVar: #byteCount type: #usqInt.
	"These need to be pointers or unsigned."
	self declareC: #(instructionPointer method newMethod)
		as: #usqInt
		in: aCCodeGenerator.
	"These are all pointers; char * because Slang has no support for C pointer arithmetic."
	self declareC: #(localIP localSP localFP nativeSP stackPointer framePointer stackLimit breakSelector nativeStackPointer nativeFramePointer shadowCallStack)
		as: #'char *'
		in: aCCodeGenerator.
	aCCodeGenerator
		var: #breakSelectorLength
		declareC: 'sqInt breakSelectorLength = MinSmallInteger'.
	self declareC: #(stackPage overflowedPage)
		as: #'StackPage *'
		in: aCCodeGenerator.
	aCCodeGenerator removeVariable: 'stackPages'.  "this is an implicit receiver in the translated code."
	NewspeakVM ifFalse:
		[aCCodeGenerator
			removeVariable: 'localAbsentReceiver';
			removeVariable: 'localAbsentReceiverOrZero';
			removeVariable: 'nsMethodCache'].
	"This defines bytecodeSetSelector as 0 if MULTIPLEBYTECODESETS
	 is not defined, for the benefit of the interpreter on slow machines."
	aCCodeGenerator addConstantForBinding: (self bindingOf: #MULTIPLEBYTECODESETS).
	MULTIPLEBYTECODESETS == false ifTrue:
		[aCCodeGenerator
			removeVariable: 'bytecodeSetSelector'].
	BytecodeSetHasExtensions == false ifTrue:
		[aCCodeGenerator
			removeVariable: 'extA';
			removeVariable: 'extB'].
	aCCodeGenerator
		var: #methodCache
		declareC: 'sqIntptr_t methodCache[MethodCacheSize + 1 /* ', (MethodCacheSize + 1) printString, ' */]'.
	aCCodeGenerator
		var: #nsMethodCache
		declareC: 'sqIntptr_t nsMethodCache[NSMethodCacheSize + 1 /* ', (NSMethodCacheSize + 1) printString, ' */]'.
	AtCacheTotalSize isInteger ifTrue:
		[aCCodeGenerator
			var: #atCache
			declareC: 'sqInt atCache[AtCacheTotalSize + 1 /* ', (AtCacheTotalSize + 1) printString, ' */]'].
	aCCodeGenerator
		var: #primitiveTable
		declareC: 'void (*primitiveTable[MaxPrimitiveIndex + 2 /* ', (MaxPrimitiveIndex + 2) printString, ' */])(void) = ', vmClass primitiveTableString.
	vmClass primitiveTable do:
		[:symbolOrNot|
		(symbolOrNot isSymbol
		 and: [symbolOrNot ~~ #primitiveFail]) ifTrue:
			[(aCCodeGenerator methodNamed: symbolOrNot) ifNotNil:
				[:tMethod| tMethod returnType: #void]]].
	vmClass objectMemoryClass hasSpurMemoryManagerAPI
		ifTrue:
			[aCCodeGenerator
				var: #primitiveAccessorDepthTable
				type: 'signed char'
				sizeString: 'MaxPrimitiveIndex + 2 /* ', (MaxPrimitiveIndex + 2) printString, ' */'
				array: vmClass primitiveAccessorDepthTable]
		ifFalse:
			[aCCodeGenerator removeVariable: #primitiveAccessorDepthTable].
	aCCodeGenerator
		var: #primitiveFunctionPointer
		declareC: 'void (*primitiveFunctionPointer)()'.
	aCCodeGenerator
		var: #externalPrimitiveTable
		declareC: 'void (*externalPrimitiveTable[MaxExternalPrimitiveTableSize + 1 /* ', (MaxExternalPrimitiveTableSize + 1) printString, ' */])(void)'.
	aCCodeGenerator var: #showSurfaceFn type: #'void *'.
	aCCodeGenerator
		var: #jmpBuf
		declareC: 'jmp_buf jmpBuf[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.
	aCCodeGenerator
		var: #suspendedCallbacks
		declareC: 'usqInt suspendedCallbacks[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.
	aCCodeGenerator
		var: #suspendedMethods
		declareC: 'usqInt suspendedMethods[MaxJumpBuf + 1 /* ', (MaxJumpBuf + 1) printString, ' */]'.
	aCCodeGenerator
		var: #interruptCheckChain
		declareC: 'void (*interruptCheckChain)(void) = 0'.

	self declareCAsUSqLong: #(nextPollUsecs nextWakeupUsecs longRunningPrimitiveGCUsecs
								longRunningPrimitiveStartUsecs longRunningPrimitiveStopUsecs
								"these are high-frequency enough that they're overflowing quite quickly on modern hardware"
								statProcessSwitch statIOProcessEvents statForceInterruptCheck
								statCheckForEvents statStackOverflow statStackPageDivorce)
		in: aCCodeGenerator.
	aCCodeGenerator var: #nextProfileTick type: #sqLong.
	
	LowcodeVM ifTrue: [
		aCCodeGenerator
			var: #shadowCallStackPointer
			type: #'char*'.
		aCCodeGenerator
			var: #lowcodeCalloutState
			type: #'sqLowcodeCalloutState*'
	].