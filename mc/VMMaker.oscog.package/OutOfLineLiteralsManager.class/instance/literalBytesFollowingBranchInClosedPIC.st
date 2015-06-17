garbage collection
literalBytesFollowingBranchInClosedPIC
	<inline: true>
	"With Spur the class tag is always 32-bits and the literal is bytesPerOop.
	 With V3 the class and literal are both bytesPerOop."
	^objectRepresentation inlineCacheTagsMayBeObjects
		ifTrue: [objectMemory bytesPerOop * 2]
		ifFalse: [objectMemory bytesPerOop + 4]