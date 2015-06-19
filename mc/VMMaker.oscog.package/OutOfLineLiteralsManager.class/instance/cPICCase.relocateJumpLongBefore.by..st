closed PIC parsing
cPICCase: caseIndex relocateJumpLongBefore: pc by: delta
	<inline: true>
	"With Spur the class tag is always 32-bits and the literal is bytesPerOop.
	 With V3 the class and literal are both bytesPerOop."
	cogit backEnd
		relocateJumpLongBeforeFollowingAddress: pc - (caseIndex <= 1
															ifTrue: [objectMemory bytesPerOop]
															ifFalse: [objectRepresentation inlineCacheTagsMayBeObjects
																		ifTrue: [objectMemory bytesPerOop * 2]
																		ifFalse: [objectMemory bytesPerOop + 4]])
		by: delta