primitives-memory management
primMalloc
	"Malloc arg bytes."
	"primMalloc: byteSize <Integer> <^Integer>
		<primitive: 'primMalloc' error: errorCode module: 'IA32ABI'>"
	| byteSize addr |
	<export: true>

	byteSize := interpreterProxy stackIntegerValue: 0.
	(interpreterProxy failed
	 or: [byteSize <= 0 "some mallocs can't deal with malloc(0) bytes"]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	addr := self cCode: [(self malloc: byteSize) asUnsignedInteger] inSmalltalk: [Alien Cmalloc: byteSize].
	addr = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoCMemory].
	interpreterProxy methodReturnValue: (self positiveMachineIntegerFor: addr)