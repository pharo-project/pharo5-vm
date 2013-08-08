primitives-memory management
primMalloc
	"Malloc arg bytes."
	"primMalloc: byteSize <Integer> <^Integer>
		<primitive: 'primMalloc' error: errorCode module: 'IA32ABI'>"
	| byteSize addr |
	<export: true>
	<var: #ptr type: 'long *'>
	<var: #byteSize type: 'long'>

	byteSize := interpreterProxy stackIntegerValue: 0.
	(interpreterProxy failed
	 or: [byteSize <= 0 "some mallocs can't deal with malloc(0) bytes"]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self cCode: 'addr = (sqInt)malloc(byteSize)'
		inSmalltalk: [addr := self Cmalloc: byteSize].
	addr = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoCMemory].
	interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: addr)