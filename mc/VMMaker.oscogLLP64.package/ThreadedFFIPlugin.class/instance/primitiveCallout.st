primitives
primitiveCallout
	"IMPORTANT: IF YOU CHANGE THE NAME OF THIS METHOD YOU MUST CHANGE
		Interpreter>>primitiveCalloutToFFI
	TO REFLECT THE CHANGE."

	"Perform a function call to a foreign function.
	Only invoked from method containing explicit external call spec."
 
	<returnTypeC: #void>
	<export: true>
	| meth externalFunction |
	meth := interpreterProxy primitiveMethod.
	(interpreterProxy literalCountOf: meth) > 0 ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadMethod].
	externalFunction := interpreterProxy literal: 0 ofMethod: meth.
	self cppIf: COGMTVM
		ifTrue:
			[ | nArgs retryCount result |
			nArgs := interpreterProxy methodArgumentCount.
			retryCount := 0.
			[result := self ffiCall: externalFunction ArgArrayOrNil: nil NumArgs: nArgs.
			 result = PrimErrObjectMayMove
			 and: [(retryCount := retryCount + 1) <= (nArgs + 1)]] whileTrue:
				[interpreterProxy tenuringIncrementalGC]]
		ifFalse:
			[self ffiCall: externalFunction ArgArrayOrNil: nil NumArgs: interpreterProxy methodArgumentCount].
	^0