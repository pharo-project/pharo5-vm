primitive support
positive64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or an eight-byte LargePositiveInteger."

	<returnTypeC: #sqLong>
	| sz value ok |
	<var: #value type: #sqLong>
	(objectMemory isIntegerObject: oop) ifTrue:
		[value := objectMemory integerValueOf: oop.
		 value < 0 ifTrue: [^self primitiveFail].
		 ^value].

	ok := objectMemory
			isClassOfNonImm: oop
			equalTo: (objectMemory splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	(ok and: [(sz := objectMemory lengthOf: oop) <= (self sizeof: #sqLong)]) ifFalse:
		[^self primitiveFail].

	value := 0.
	0 to: sz - 1 do: [:i |
		value := value + ((self cCoerce: (objectMemory fetchByte: i ofObject: oop) to: #sqLong) <<  (i*8))].
	^value