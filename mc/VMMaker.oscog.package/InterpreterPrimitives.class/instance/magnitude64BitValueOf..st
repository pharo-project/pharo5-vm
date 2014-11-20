primitive support
magnitude64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a eight-byte LargeInteger."
	| sz value ok smallIntValue |
	<returnTypeC: #usqLong>
	<var: #value type: #usqLong>

	(objectMemory isIntegerObject: oop) ifTrue:
		[smallIntValue := (objectMemory integerValueOf: oop).
		smallIntValue < 0 ifTrue: [smallIntValue := 0 - smallIntValue].
		^self cCoerce: smallIntValue to: #usqLong].

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[^self primitiveFail].

	ok := objectMemory isClassOfNonImm: oop
					equalTo: (objectMemory splObj: ClassLargePositiveInteger)
					compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok
		ifFalse:
			[ok := objectMemory isClassOfNonImm: oop
							equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
							compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
			ok ifFalse: [^self primitiveFail]].
	sz := objectMemory numBytesOf: oop.
	sz > (self sizeof: #sqLong) ifTrue:
		[^self primitiveFail].

	value := 0.
	0 to: sz - 1 do: [:i |
		value := value + ((self cCoerce: (objectMemory fetchByte: i ofObject: oop) to: #sqLong) <<  (i*8))].
	^value