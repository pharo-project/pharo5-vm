garbage collection
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	"If inline cache tags are not objects they will be 32-bit values."
	objectRepresentation inlineCacheTagsMayBeObjects
		ifTrue: [objectMemory long32At: address - 4 put: classObj]
		ifFalse: [objectMemory longAt: address - objectMemory bytesPerOop]