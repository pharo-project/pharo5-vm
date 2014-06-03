primitives
primitiveCallout

	"IMPORTANT: IF YOU CHANGE THE NAME OF THIS METHOD YOU MUST CHANGE
		Interpreter>>primitiveCalloutToFFI
	TO REFLECT THE CHANGE."

	"Perform a function call to a foreign function.
	Only invoked from method containing explicit external call spec."
	| lit address flags argTypes litClass nArgs meth |
	<export: true>
	<inline: false>
	self ffiSetLastError: FFIErrorGenericError. "educated guess if we fail silently"
	lit := nil.
	"Look if the method is itself a callout function"
	meth := interpreterProxy primitiveMethod.
	(interpreterProxy literalCountOf: meth) > 0 ifFalse:[^interpreterProxy primitiveFail].
	lit := interpreterProxy literal: 0 ofMethod: meth.
	litClass := interpreterProxy fetchClassOf: lit.
	(interpreterProxy includesBehavior: litClass 
						ThatOf: interpreterProxy classExternalFunction) 
		ifFalse:[^self ffiFail: FFIErrorNotFunction].
	address := self ffiLoadCalloutAddress: lit.
	interpreterProxy failed ifTrue:[^0].
	"Load and check the other values before we call out"
	flags := interpreterProxy fetchInteger: 1 ofObject: lit.
	interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorBadArgs].
	argTypes := interpreterProxy fetchPointer: 2 ofObject: lit.
	"must be array of arg types"
	(interpreterProxy isArray: argTypes)
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	nArgs := interpreterProxy slotSizeOf: argTypes.
	"must be argumentCount+1 arg types"
	nArgs = (interpreterProxy methodArgumentCount+1) 
		ifFalse:[^self ffiFail: FFIErrorBadArgs].
	self ffiLogCallout: lit.
	self ffiInitialize. "announce the execution of an external call"
	self ffiCall: address 
		WithFlags: flags 
		AndTypes: argTypes.
	self ffiCleanup. "cleanup temp allocations"
	^0