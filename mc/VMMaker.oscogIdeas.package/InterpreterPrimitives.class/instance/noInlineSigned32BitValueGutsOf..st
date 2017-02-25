primitive support
noInlineSigned32BitValueGutsOf: oop
	"Convert the given object into an integer value.
	The object may be a four-byte LargeInteger."
	| value negative ok magnitude |
	<notOption: #Spur64BitMemoryManager>
	<inline: false>
	<returnTypeC: #int>
	<var: #value type: #int>
	<var: #magnitude type: #'unsigned int'>
	self deny: objectMemory hasSixtyFourBitImmediates.
	self deny: (objectMemory isIntegerObject: oop).

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[self primitiveFail.
		 ^0].

	ok := objectMemory
			isClassOfNonImm: oop
			equalTo: (objectMemory splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok
		ifTrue: [negative := false]
		ifFalse:
			[negative := true.
			 ok := objectMemory isClassOfNonImm: oop
							equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
							compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
			 ok ifFalse:
				[self primitiveFail.
				 ^0]].
	(objectMemory numBytesOfBytes: oop) > 4 ifTrue:
		[^self primitiveFail].

	magnitude := self cCoerceSimple: (objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: oop)) to: #'unsigned int'.

	(negative
		ifTrue: [magnitude > 16r80000000]
		ifFalse: [magnitude >= 16r80000000])
			ifTrue:
				[self primitiveFail.
				^0].
	negative
		ifTrue: [value := 0 - magnitude]
		ifFalse: [value := magnitude].
	^value