primitives-callbacks
primReturnAsFromContextThrough
	"Return a result from a callback to the callback's callee.  The primitive
	 has a signature of either of the forms:
		result <VMCallbackContext32/64>
				primReturnAs: returnTypeCode <Integer>
				FromContext: callbackContext <Context>
		result <VMCallbackContext32/64>
				primSignal: aSemaphore <Semaphore>
				andReturnAs: returnTypeCode <Integer>
				FromContext: callbackContext <Context>
			<primitive: 'primReturnAsFromContextThrough' error: errorCode module: 'IA32ABI'>.
	 If of the second form answer false if this is not the most recent callback, and signal aSemaphore
	 if it is, so as to implement LIFO ordering of callbacks."
	<export: true>
	| vmCallbackContext isMostRecent |
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	interpreterProxy methodArgumentCount = 3
		ifTrue:
			[vmCallbackContext := self cCoerceSimple: (self startOfData: (interpreterProxy stackValue: 3))
										to: #'VMCallbackContext *'.
			 isMostRecent := vmCallbackContext = self getMostRecentCallbackContext.
			 isMostRecent ifFalse:
				[^interpreterProxy methodReturnValue: interpreterProxy falseObject].
			(interpreterProxy fetchClassOf: (interpreterProxy stackValue: 2)) = interpreterProxy classSemaphore ifFalse:
				[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
			[interpreterProxy signalNoResume: (interpreterProxy stackValue: 2)] whileFalse]
		ifFalse:
			[vmCallbackContext := self cCoerceSimple: (self startOfData: (interpreterProxy stackValue: 2))
										to: #'VMCallbackContext *'].
	(interpreterProxy
		returnAs: (interpreterProxy stackValue: 1)
		ThroughCallback: vmCallbackContext
		Context: (interpreterProxy stackValue: 0)) ifFalse:
			[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	"NOTREACHED"