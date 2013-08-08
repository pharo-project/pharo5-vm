debug printing
lengthOfNameOfClass: classOop
	<inline: false>
	(self sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[^self lengthOfNameOfClass: (self fetchPointer: thisClassIndex ofObject: classOop)].
	^self lengthOf: (self fetchPointer: classNameIndex ofObject: classOop)