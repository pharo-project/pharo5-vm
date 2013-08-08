primitives-callouts
primVarArgsCallOutDoubleReturn
	"Call a foreign function that answers a double-precision floating-point result in %f0
	 according to IA32-ish ABI rules. The primitive will have a signature of the form
	functionAddress <Alien> primFFICallResult: result <Alien|Object> withArguments: args <Array of: Alien | Integer> ^<Alien>
		<primitive: 'primVarArgsCallOutDoubleReturn' error: errorCode module: 'IA32ABI'>.
	Answer result. If result is an Alien the value answered by the call will be assigned to result."
	| array mac errCode result |
	<export: true>
	array := interpreterProxy stackValue: 0.
	(interpreterProxy isArray: array) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	mac := interpreterProxy methodArgumentCount.
	errCode := self call: (interpreterProxy firstIndexableField: array)	"ptr to 0th arg"
					IA32: (interpreterProxy stSizeOf: array)				"nargs"
					Double: 2											"func stackValue"
					Return: 1.											"result stackValue"
	errCode ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: errCode].
	result := interpreterProxy stackValue: 1.
	interpreterProxy pop: mac + 1 thenPush: result