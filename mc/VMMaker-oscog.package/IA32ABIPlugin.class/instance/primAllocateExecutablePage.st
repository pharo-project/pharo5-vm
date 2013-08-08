primitives-memory management
primAllocateExecutablePage
	"Answer an Alien for an executable page; for thunks"
	"primAllocateExecutablePage ^<Alien>
		<primitive: 'primAllocateExecutablePage' error: errorCode module: 'IA32ABI'>"
	| byteSize ptr mem alien |
	<export: true>
	<var: #byteSize type: 'long'>
	<var: #ptr type: 'long *'>
	<var: #mem type: 'void *'>

	self cCode: 'mem = allocateExecutablePage(&byteSize)'
		inSmalltalk: [self error: 'not yet implemented'. mem := 0. byteSize := 0].
	mem = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoCMemory].
	alien := interpreterProxy
				instantiateClass: interpreterProxy classAlien
				indexableSize: 8.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	ptr := interpreterProxy firstIndexableField: alien.
	ptr at: 0 put: 0 - byteSize. "indirect mem indicated by negative size. Slang doesn't grok negated"
	ptr at: 1 put: (self cCoerce: mem to: 'long').
	interpreterProxy methodReturnValue: alien