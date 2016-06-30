primitives-memory management
primFree
	"Free the memory referenced by the argument, an integer."
	"<Anywhere> primFree: address <Integer>
		<primitive: 'primFree' error: errorCode module: 'IA32ABI'>"
	| addr |
	<export: true>
	addr := interpreterProxy stackPositiveMachineIntegerValue: 0.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	"Don't you dare to free Squeak's memory!"
	(addr = 0 or: [interpreterProxy isInMemory: addr]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	self cCode: 'free((void *)addr)'
		inSmalltalk: [self Cfree: addr].
	interpreterProxy pop: 1