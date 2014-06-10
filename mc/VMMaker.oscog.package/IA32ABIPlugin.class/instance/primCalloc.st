primitives-memory management
primCalloc
	"calloc (malloc + zero-fill) arg bytes."
	"primCalloc: byteSize <Integer> ^<Integer>
		<primitive: 'primCalloc' error: errorCode module: 'IA32ABI'>"
	| byteSize addr |
	<export: true>
	<var: #byteSize type: #long>

	byteSize := interpreterProxy stackIntegerValue: 0.
	(interpreterProxy failed
	 or: [byteSize <= 0 "some mallocs can't deal with malloc(0) bytes"]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self cCode: 'addr = (sqInt)calloc(1,byteSize)'
		inSmalltalk: [addr := self Ccalloc: byteSize].
	addr = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoCMemory].
	interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: addr)