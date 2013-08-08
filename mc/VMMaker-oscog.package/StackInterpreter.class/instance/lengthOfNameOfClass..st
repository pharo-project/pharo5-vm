debug printing
lengthOfNameOfClass: classOop
	<inline: false>
	(objectMemory sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[^self lengthOfNameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop)].
	^objectMemory lengthOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)