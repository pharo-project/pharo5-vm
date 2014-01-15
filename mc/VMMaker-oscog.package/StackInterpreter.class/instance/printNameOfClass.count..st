debug printing
printNameOfClass: classOop count: cnt
	"Details: The count argument is used to avoid a possible infinite recursion if classOop is a corrupted object."
	<inline: false>
	(classOop = 0 or: [cnt <= 0]) ifTrue: [^self print: 'bad class'].
	((objectMemory sizeBitsOf: classOop) = metaclassSizeBits
	  and: [metaclassSizeBits > (thisClassIndex * BytesPerWord)])	"(Metaclass instSize * 4)"
		ifTrue: [self printNameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop) count: cnt - 1.
				self print: ' class']
		ifFalse: [self printStringOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)]