primitives
primitiveCalloutWithArgs
	"Perform a function call to a foreign function.
	Only invoked from ExternalFunction>>invokeWithArguments:"
	| lit address flags argTypes litClass nArgs argArray |
	<export: true>
	<inline: false>
	self ffiSetLastError: FFIErrorGenericError. "educated guess if we fail silently"
	lit := nil.
	"Look if the method is itself a callout function"
	lit := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	litClass := interpreterProxy fetchClassOf: lit.
	(interpreterProxy includesBehavior: litClass 
						ThatOf: interpreterProxy classExternalFunction) 
		ifFalse:[^self ffiFail: FFIErrorNotFunction].
	address := self ffiLoadCalloutAddress: lit.
	interpreterProxy failed ifTrue:[^nil].
	"Load and check the other values before we call out"
	flags := interpreterProxy fetchInteger: 1 ofObject: lit.
	interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorBadArgs].
	argTypes := interpreterProxy fetchPointer: 2 ofObject: lit.
	"must be array of arg types"
	(interpreterProxy isArray: argTypes) 
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	nArgs := interpreterProxy slotSizeOf: argTypes.
	(interpreterProxy methodArgumentCount = 1) 
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	argArray := interpreterProxy stackValue: 0.
	(interpreterProxy isArray: argArray)
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	nArgs = ((interpreterProxy slotSizeOf: argArray) + 1)
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	self ffiInitialize. "announce the execution of an external call"
	self ffiCall: address 
		WithFlags: flags 
		Args: argArray
		AndTypes: argTypes
		OfSize: nArgs-1.
	self ffiCleanup. "cleanup temp allocations"
	^0