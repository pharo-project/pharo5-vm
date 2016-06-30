primitives-callbacks
primReturnFromContextThrough
	"Return a result from a callback to the callback's callee.  The primitive
	 has a signature of either of the forms:
		result <FFICallbackResult> primReturnFromContext: callbackContext <MethodContext> through: jmpBuf <Integer>
		result <FFICallbackResult> primSignal: aSemaphore <Semaphore> andReturnFromContext: callbackContext <MethodContext> through: jmpBuf <Integer>
			<primitive: 'primReturnFromContextThrough' error: errorCode module: 'IA32ABI'>.
	 If of the second form answer true if this is not the most recent callback, and signal aSemaphore
	 if it is, so as to implement LIFO ordering of callbacks."
	<export: true>
	<legacy>
	| mac vmCallbackContext vmCallbackReturnValue isMostRecent |
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	<var: #vmCallbackReturnValue type: #'VMCallbackReturnValue *'>
	vmCallbackContext := self cCoerceSimple: (interpreterProxy positiveMachineIntegerValueOf: (interpreterProxy stackValue: 0))
								to: #'VMCallbackContext *'.
	(interpreterProxy failed or: [vmCallbackContext = 0]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(mac := interpreterProxy methodArgumentCount) = 3 ifTrue:
		[isMostRecent := vmCallbackContext = self getMostRecentCallbackContext.
		isMostRecent ifFalse:
			[interpreterProxy methodReturnValue: interpreterProxy trueObject.
			^nil].
		(interpreterProxy fetchClassOf: (interpreterProxy stackValue: 2)) = interpreterProxy classSemaphore
			ifFalse: [^interpreterProxy primitiveFailFor: PrimErrBadArgument].
		[interpreterProxy signalNoResume: (interpreterProxy stackValue: 2)] whileFalse].
	vmCallbackReturnValue := self cCoerceSimple: (self startOfData: (interpreterProxy stackValue: mac))
									to: #'VMCallbackReturnValue *'.
	self cCode: "C needs a typedef for structs to be assigned, but that implies a struct class for just one assignment."
		[self mem: (self addressOf: vmCallbackContext rvs)
			cp: (self addressOf: vmCallbackReturnValue crvrvs)
			y: (self sizeof: vmCallbackContext rvs)]
		inSmalltalk: [vmCallbackContext rvs: vmCallbackReturnValue crvrvs].
	(interpreterProxy
		returnAs: (interpreterProxy integerObjectOf: vmCallbackReturnValue type + 1)
		ThroughCallback: vmCallbackContext
		Context: (interpreterProxy stackValue: 1)) ifFalse:
			[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	"NOTREACHED"