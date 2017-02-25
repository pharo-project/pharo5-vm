simulation
lookupAddress: address
	"If address appears to be that of a Symbol or a few well-known objects (such as classes) answer it, otherwise answer nil.
	 For code disassembly"
	<doNotGenerate>
	(objectMemory lookupAddress: address) ifNotNil:
		[:lookup| ^lookup].
	address / objectMemory wordSize = primTraceLog offset ifTrue: [^'primTraceLog'].
	^nil