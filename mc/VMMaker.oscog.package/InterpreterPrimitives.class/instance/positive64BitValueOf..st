primitive support
positive64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or an eight-byte LargePositiveInteger."

	<returnTypeC: #usqLong>
	| sz value ok |
	<var: #value type: #usqLong>
	(objectMemory isIntegerObject: oop) ifTrue:
		[(objectMemory integerValueOf: oop) < 0 ifTrue:
			[^self primitiveFail].
		 ^objectMemory integerValueOf: oop].

	ok := objectMemory
			isClassOfNonImm: oop
			equalTo: (objectMemory splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	(ok and: [(sz := objectMemory lengthOf: oop) <= (self sizeof: #sqLong)]) ifFalse:
		[^self primitiveFail].

	value := 0.
	0 to: sz - 1 do: [:i |
		value := value + ((self cCoerce: (objectMemory fetchByte: i ofObject: oop) to: #usqLong) <<  (i*8))].
	^value