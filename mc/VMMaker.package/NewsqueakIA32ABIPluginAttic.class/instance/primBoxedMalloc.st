primitives-memory management
primBoxedMalloc
	"This version boxes the result."
	"Malloc arg bytes."
	"primBoxedMalloc: byteSize <Integer>
		<primitive: 'primBoxedMalloc' module: 'IA32ABI'>"
	| byteSize addr oop ptr |
	<export: true>
	<inline: false>
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
	oop := interpreterProxy 
			instantiateClass: interpreterProxy classAlien
			indexableSize: 2 * BytesPerOop.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: 0 - byteSize. "indirect args indicated by negative size. Slang doesn't grok negated"
	ptr at: 1 put: addr.
	interpreterProxy pop: 2 thenPush: oop.
