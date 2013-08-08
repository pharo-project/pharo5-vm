primitives-callouts
primCallOutIntegralReturnAnywhere
	"Call a foreign function that answers an integral result in %eax (and possibly %edx)
	 according to IA32-ish ABI rules. The primitive will have a signature of the form
	<Anywhere> primFFICall: functionAddress <Alien> result: result <Alien|Object> with: firstArg <Alien> ... with: lastArg <Alien>
		<primitive: 'primCallOutIntegralReturnAnywhere' error: errorCode module: 'IA32ABI'>.
	Answer result. If result is an Alien the value answered by the call will be assigned to result."
	| errCode mac result |
	<export: true>
	mac := interpreterProxy methodArgumentCount.
	(self isAlien:  (interpreterProxy stackValue: mac - 2)) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self cppIf: STACKVM
		ifTrue: "In the STACKVM stacks grow down"
			[self cCode: 'errCode = callIA32IntegralReturn(interpreterProxy->getStackPointer() + mac - 3, /* arg vec */
															2 - mac	/* nargs */,
															mac	/* funcOffset*/,
															mac - 2	/* resultOffset */)'
				inSmalltalk: [errCode := PrimErrUnsupported]]
		ifFalse:
			[self cCode: 'errCode = callIA32IntegralReturn(interpreterProxy->getStackPointer() - mac + 3, /* arg vec */
															mac - 2	/* nargs */,
															mac	/* funcOffset*/,
															mac - 2	/* resultOffset */)'
				inSmalltalk: [errCode := PrimErrUnsupported]].
	errCode ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: errCode].
	result := interpreterProxy stackValue: mac - 2.
	interpreterProxy pop: mac + 1 thenPush: result