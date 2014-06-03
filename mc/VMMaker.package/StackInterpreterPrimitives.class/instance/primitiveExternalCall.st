plugin primitives
primitiveExternalCall
	"Call an external primitive. External primitive methods first literals are an array of
		* The module name (String | Symbol)
		* The function name (String | Symbol)
		* The session ID (SmallInteger) [OBSOLETE] (or in Spur, the accessorDepth)
		* The function index (Integer) in the externalPrimitiveTable
	For fast interpreter dispatch in subsequent invocations the primitiveFunctionPointer
	in the method cache is rewritten, either to the function itself, or to zero if the external
	function is not found.   This allows for fast responses as long as the method stays in
	the cache. The cache rewrite relies on lastMethodCacheProbeWrite which is set in
	addNewMethodToCache:.
	Now that the VM flushes function addresses from its tables, the session ID is obsolete,
	but it is kept for backward compatibility. Also, a failed lookup is reported specially. If a
	method has been  looked up and not been found, the function address is stored as -1
	(i.e., the SmallInteger -1 to distinguish from 16rFFFFFFFF which may be returned from
	lookup), and the primitive fails with PrimErrNotFound."
	| lit addr moduleName functionName moduleLength functionLength accessorDepth index |
	<var: #addr declareC: 'void (*addr)()'>
	
	"Fetch the first literal of the method"
	(self literalCountOf: newMethod) > 0 ifFalse:
		[^self primitiveFailFor: PrimErrBadMethod].

	lit := self literal: 0 ofMethod: newMethod. 
	"Check if it's an array of length 4"
	((objectMemory isArray: lit) and: [(objectMemory lengthOf: lit) = 4]) ifFalse:
		[^self primitiveFailFor: PrimErrBadMethod].

	"Look at the function index in case it has been loaded before"
	index := objectMemory fetchPointer: 3 ofObject: lit.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadMethod].
	index := objectMemory integerValueOf: index.
	"Check if we have already looked up the function and failed."
	index < 0 ifTrue:
		["Function address was not found in this session, 
		  Void the primitive function."
		 self rewriteMethodCacheEntryForExternalPrimitiveToFunction: 0.
		 ^self primitiveFailFor: PrimErrNotFound].

	"Try to call the function directly"
	(index > 0 and: [index <= MaxExternalPrimitiveTableSize]) ifTrue:
		[addr := externalPrimitiveTable at: index - 1.
		 addr ~= 0 ifTrue:
			[self rewriteMethodCacheEntryForExternalPrimitiveToFunction: (self cCode: 'addr' inSmalltalk: [1000 + index]).
			 self callExternalPrimitive: addr.
			 ^nil].
		"if we get here, then an index to the external prim was 
		kept on the ST side although the underlying prim 
		table was already flushed"
		^self primitiveFailFor: PrimErrNamedInternal].

	"Clean up session id and external primitive index"
	objectMemory storePointerUnchecked: 2 ofObject: lit withValue: ConstZero.
	objectMemory storePointerUnchecked: 3 ofObject: lit withValue: ConstZero.

	"The function has not been loaded yet. Fetch module and function name."
	moduleName := objectMemory fetchPointer: 0 ofObject: lit.
	moduleName = objectMemory nilObject
		ifTrue: [moduleLength := 0]
		ifFalse: [(objectMemory isBytes: moduleName) ifFalse:
					[self primitiveFailFor: PrimErrBadMethod].
				moduleLength := objectMemory lengthOf: moduleName].
	functionName := objectMemory fetchPointer: 1 ofObject: lit.
	(objectMemory isBytes: functionName) ifFalse:
		[self primitiveFailFor: PrimErrBadMethod].
	functionLength := objectMemory lengthOf: functionName.

	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[addr := self ioLoadExternalFunction: functionName + BaseHeaderSize
						OfLength: functionLength
						FromModule: moduleName + BaseHeaderSize
						OfLength: moduleLength
						AccessorDepthInto: (self addressOf: accessorDepth
												 put: [:val| accessorDepth := val]).
			 addr = 0
				ifTrue: [index := -1]
				ifFalse: "add the function to the external primitive table"
					[index := self addToExternalPrimitiveTable: addr.
					 objectMemory
						storePointerUnchecked: 2
						ofObject: lit
						withValue: (objectMemory integerObjectOf: accessorDepth)]]
		ifFalse:
			[addr := self ioLoadExternalFunction: functionName + BaseHeaderSize
						OfLength: functionLength
						FromModule: moduleName + BaseHeaderSize
						OfLength: moduleLength.
			 addr = 0
				ifTrue: [index := -1]
				ifFalse: "add the function to the external primitive table"
					[index := self addToExternalPrimitiveTable: addr]].

	"Store the index (or -1 if failure) back in the literal"
	objectMemory storePointerUnchecked: 3 ofObject: lit withValue: (objectMemory integerObjectOf: index).

	"If the function has been successfully loaded cache and call it"
	index >= 0
		ifTrue:
			[self rewriteMethodCacheEntryForExternalPrimitiveToFunction: (self cCode: [addr] inSmalltalk: [1000 + index]).
			 self callExternalPrimitive: addr]
		ifFalse: "Otherwise void the primitive function and fail"
			[self rewriteMethodCacheEntryForExternalPrimitiveToFunction: 0.
			 self assert: (objectMemory fetchPointer: 2 ofObject: lit) = ConstZero.
			 self primitiveFailFor: PrimErrNotFound]