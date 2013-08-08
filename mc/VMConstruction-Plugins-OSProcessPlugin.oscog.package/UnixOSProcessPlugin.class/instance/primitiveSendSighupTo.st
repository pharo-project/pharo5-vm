primitives - OS signals
primitiveSendSighupTo
	"Send SIGHUP (hangup) to the OS process identified by the argument. Use an explicit
	check for isIntegerObject so we can return -1 on error (the stackIntegerValue: method
	answers 1 on error, and 1 is a valid pid number)."

	| result pidToSignal |
	<export: true>
	<var: 'pidToSignal' type: 'pid_t'>
	<var: 'result' type: 'int'>

	"Do not allow signal sending if running in secure mode"
	(self sandboxSecurity == 1)
		ifTrue:
			[interpreterProxy pop: 2; pushInteger: -1]
		ifFalse:
			[(interpreterProxy isIntegerObject: (interpreterProxy stackValue: 0))
				ifTrue: 
					[pidToSignal := interpreterProxy stackIntegerValue: 0.
					result := self sendSignal: self sigHupNumber toPid: pidToSignal.
					interpreterProxy pop: 2; pushInteger: result]
				ifFalse: [interpreterProxy pop: 2; pushInteger: -1]]