bootstrap image
shouldClone: obj32
	| classIndex value |
	(heap32 isValidObjStackPage: obj32) ifTrue:
		[^false].

	classIndex := heap32 classIndexOf: obj32.

	((classIndex between: ClassLargeNegativeIntegerCompactIndex and: ClassLargePositiveIntegerCompactIndex)
	 and: [interpreter32 initPrimCall.
		   value := interpreter32 signed64BitValueOf: obj32.
		   interpreter32 failed not
		   and: [heap64 isIntegerValue: value]]) ifTrue:
		[^false].

	(classIndex = ClassFloatCompactIndex
	and: [value := heap32 floatValueOf: obj32.
		heap64 isSmallFloatValue: value]) ifTrue:
		[^false].

	^true