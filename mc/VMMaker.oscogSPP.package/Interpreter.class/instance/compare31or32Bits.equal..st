arithmetic primitive support
compare31or32Bits: obj1 equal: obj2
	"May set success to false"

	"First compare two ST integers..."
	((self isIntegerObject: obj1)
		and: [self isIntegerObject: obj2])
		ifTrue: [^ obj1 = obj2].

	"Now compare, assuming positive integers, but setting fail if not"
	^ (self positive32BitValueOf: obj1) = (self positive32BitValueOf: obj2)