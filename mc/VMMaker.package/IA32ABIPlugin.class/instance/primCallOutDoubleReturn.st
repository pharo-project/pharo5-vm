primitives-callouts
primCallOutDoubleReturn
	"Call a foreign function that answers a double-precision floating-point result in %f0
	 according to IA32-ish ABI rules. The primitive will have a signature of the form
	functionAddress <Alien> primFFICallResult: result <Alien|Object> with: firstArg <Alien | Integer> ... with: lastArg <Alien | Integer> ^<Alien>
		<primitive: 'primCallOutDoubleReturn' error: errorCode module: 'IA32ABI'>.
	Answer result. If result is an Alien the value answered by the call will be assigned to result."
	| errCode mac result |
	<export: true>
	mac := interpreterProxy methodArgumentCount.
	self cppIf: STACKVM
		ifTrue: "In the STACKVM stacks grow down"
			[errCode := self call: interpreterProxy getStackPointer + mac - 2 "ptr to 0th arg"
							IA32: 1 - mac	"nargs negated to imply stack direction"
							Double: mac	"funcOffset"
							Return: mac - 1	"resultOffset"]
		ifFalse:
			[errCode := self call: interpreterProxy getStackPointer - mac + 2 "ptr to 0th arg"
							IA32: mac - 1	"nargs"
							Double: mac	"funcOffset"
							Return: mac - 1	"resultOffset"].
	errCode ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: errCode].
	result := interpreterProxy stackValue: mac - 1.
	interpreterProxy pop: mac + 1 thenPush: result