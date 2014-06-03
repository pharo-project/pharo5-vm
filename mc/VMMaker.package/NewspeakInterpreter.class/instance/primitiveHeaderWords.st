other primitives
primitiveHeaderWords
	"Primitive. Answer an Array of the integers representing the header words for the argument."
	| obj hdr1 result size |
	obj := self stackTop.
	(self isIntegerObject: obj) ifTrue:
		[self primitiveFail. ^nil].
	(self headerType: obj) = HeaderTypeShort
		ifTrue: [size := 1]
		ifFalse:
			[(self headerType: obj) = HeaderTypeClass
				ifTrue: [size := 2]
				ifFalse:
					[size := 3]].
	result := self instantiateClass: self classArray indexableSize: size. "can cause GC"
	obj := self stackTop.
	self storePointer: 0 ofObject: result withValue: (self positive32BitIntegerFor: (self baseHeader: obj)).
	size > 1 ifTrue:
		[self storePointer: 1 ofObject: result withValue: (self positive32BitIntegerFor: (self classHeader: obj))].
	size > 2 ifTrue:
		[self storePointer: 2 ofObject: result withValue: (self positive32BitIntegerFor: (self sizeHeader: obj))].
	self pop: self methodArgumentCount + 1 thenPush: result.