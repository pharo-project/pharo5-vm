primitives
primitiveCalloutWithArgs
	"Perform a function call to a foreign function.
	 Only invoked from ExternalFunction>>invokeWithArguments:"

	<returnTypeC: #void>
	<export: true>
	| externalFunction argArray nArgs |
	interpreterProxy methodArgumentCount = 1 ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	self cppIf: COGMTVM
		ifTrue:
			[| retryCount result |
			retryCount := 0.
			[externalFunction := interpreterProxy stackValue: 1.
			 argArray := interpreterProxy stackValue: 0.
			 (interpreterProxy isArray: argArray) ifFalse:
				[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
			 nArgs := interpreterProxy slotSizeOf: argArray.
			 result := self ffiCall: externalFunction ArgArrayOrNil: argArray NumArgs: nArgs.
			 result = PrimErrObjectMayMove
			  and: [(retryCount := retryCount + 1) <= (nArgs + 1)]] whileTrue:
				[interpreterProxy tenuringIncrementalGC]]
		ifFalse:
			[externalFunction := interpreterProxy stackValue: 1.
			argArray := interpreterProxy stackValue: 0.
			(interpreterProxy isArray: argArray) ifFalse:
				[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
			nArgs := interpreterProxy slotSizeOf: argArray.
			self ffiCall: externalFunction ArgArrayOrNil: argArray NumArgs: nArgs].
	^0