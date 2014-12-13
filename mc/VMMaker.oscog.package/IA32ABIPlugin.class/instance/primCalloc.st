primitives-memory management
primCalloc
	"calloc (malloc + zero-fill) arg bytes."
	"primCalloc: byteSize <Integer> ^<Integer>
		<primitive: 'primCalloc' error: errorCode module: 'IA32ABI'>"
	| byteSize addr |
	<export: true>

	byteSize := interpreterProxy stackIntegerValue: 0.
	(interpreterProxy failed
	 or: [byteSize <= 0 "some mallocs can't deal with malloc(0) bytes"]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	addr := self cCode: [(self c: 1 alloc: byteSize) asUnsignedInteger] inSmalltalk: [Alien Ccalloc: byteSize].
	addr = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoCMemory].
	interpreterProxy methodReturnValue: (self positiveMachineIntegerFor: addr)