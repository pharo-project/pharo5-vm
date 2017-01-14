primitive support
maybeInlinePositive32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargePositiveInteger."
	<notOption: #Spur64BitMemoryManager>
	<returnTypeC: #'unsigned int'>
	| value ok sz |
	(objectMemory isIntegerObject: oop) ifTrue:
		[value := objectMemory integerValueOf: oop.
		 (value < 0) ifTrue:
			[self primitiveFail. value := 0].
		 ^value].

	(objectMemory isNonIntegerImmediate: oop)
		ifTrue:
			[self primitiveFail.
			 ^0]
		ifFalse:
			[ok := objectMemory
					isClassOfNonImm: oop
					equalTo: (objectMemory splObj: ClassLargePositiveInteger)
					compactClassIndex: ClassLargePositiveIntegerCompactIndex.
			ok ifFalse:
				[self primitiveFail.
				 ^0].
			sz := objectMemory numBytesOfBytes: oop.
			sz > 4 ifTrue:
				[self primitiveFail.
				 ^0].
			^self cCoerceSimple: (objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: oop)) to: #'unsigned int']