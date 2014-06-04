debugging traps
primitiveIdentityHash
	"| oop |
	oop := self stackTop.
	((objectMemory isBytes: oop)
	and: [(objectMemory lengthOf: oop) = 'smallSelect' size
	and: [(self stringOf: oop) = 'smallSelect']]) ifTrue:
		[self halt]."
	^super primitiveIdentityHash