testing
validOop: oop
	" Return true if oop appears to be valid "
	(oop bitAnd: 1) = 1 ifTrue: [^ true].  "Integer"
	(oop bitAnd: 3) = 0 ifFalse: [^ false].  "Uneven address"
	oop >= endOfMemory ifTrue: [^ false].  "Out of range"
	"could test if within the first large freeblock"
	(self longAt: oop) = 4 ifTrue: [^ false].
	(self headerType: oop) = 2 ifTrue: [^ false].	"Free object"
	^ true