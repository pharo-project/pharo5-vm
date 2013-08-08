primitives - OS signals
primitiveCanReceiveSignals
	"Send a null signal to the OS process identified by the argument. Answer false for
	a bad parameter on the stack (the common case is for the argument equal to nil,
	for which case we should answer false). Answer true if the process exists and can
	receive signals from this process, otherwise false. This test is useful for determining
	if a child process still exists following a Squeak image restart."

	| result pidToSignal |
	<export: true>
	<var: 'pidToSignal' type: 'pid_t'>
	<var: 'result' type: 'int'>
	(interpreterProxy isIntegerObject: (interpreterProxy stackValue: 0))
		ifTrue: 
			[pidToSignal := interpreterProxy stackIntegerValue: 0.
			result := self cCode: 'kill(pidToSignal, 0)' inSmalltalk: [-1].
			interpreterProxy pop: 2.
			(result == 0)
				ifTrue: [interpreterProxy push: interpreterProxy trueObject]
				ifFalse: [interpreterProxy push: interpreterProxy falseObject]]
		ifFalse: [interpreterProxy pop: 2; push: interpreterProxy falseObject]