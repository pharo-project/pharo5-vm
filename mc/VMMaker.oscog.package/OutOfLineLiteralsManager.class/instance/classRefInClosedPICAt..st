garbage collection
classRefInClosedPICAt: address
	<inline: true>
	"If inline cache tags are not objects they will be 32-bit values."
	^objectRepresentation inlineCacheTagsMayBeObjects
		ifTrue: [objectMemory long32At: address - 4]
		ifFalse: [objectMemory longAt: address - objectMemory bytesPerOop]