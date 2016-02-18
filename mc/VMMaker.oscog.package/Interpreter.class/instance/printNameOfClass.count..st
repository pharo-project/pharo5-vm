debug printing
printNameOfClass: classOop count: cnt
	"Details: The count argument is used to avoid a possible infinite recursion if classOop is a corrupted object."

	cnt <= 0 ifTrue: [^self print: 'bad class'].
	((self sizeBitsOf: classOop) = metaclassSizeBits
	  and: [metaclassSizeBits >= (6 * self wordSize)])	"(Metaclass instSize * 4)"
		ifTrue: [self printNameOfClass: (self fetchPointer: 5 "thisClass" ofObject: classOop) count: cnt - 1.
				self print: ' class']
		ifFalse: [self printStringOf: (self fetchPointer: 6 "name" ofObject: classOop)]