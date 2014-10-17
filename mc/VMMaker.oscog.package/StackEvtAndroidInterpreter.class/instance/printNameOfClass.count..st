process primitive support
printNameOfClass: classOop count: cnt
	"Details: The count argument is used to avoid a possible infinite recursion if classOop is a corrupted object."
	<inline: false>
	(classOop = 0 or: [cnt <= 0]) ifTrue: [^self sdprintf: 'bad class'].
	((objectMemory sizeBitsOf: classOop) = metaclassSizeBits
	  and: [metaclassSizeBits > (thisClassIndex * BytesPerWord)])	"(Metaclass instSize * 4)"
		ifTrue: [self printNameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop) count: cnt - 1.]
		ifFalse: [self printStringOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)]