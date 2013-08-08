debug support
nameOfClass: classOop
	(objectMemory sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[^(self nameOfClass:
				(objectMemory fetchPointer: thisClassIndex ofObject: classOop)) , ' class'].
	^self stringOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)