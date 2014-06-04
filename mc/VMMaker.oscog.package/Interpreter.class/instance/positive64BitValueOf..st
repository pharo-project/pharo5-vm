primitive support
positive64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or an eight-byte LargePositiveInteger."

	| sz szsqLong value  |
	<returnTypeC: #sqLong>
	<var: #value type: #sqLong>
	(self isIntegerObject: oop) ifTrue:
		[value := self integerValueOf: oop.
		value < 0 ifTrue: [^self primitiveFail].
		^ value].

	(self
			isClassOfNonImm: oop
			equalTo: (self splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex) ifFalse:
		[^self primitiveFail].
	szsqLong := self sizeof: #sqLong.
	sz := self lengthOf: oop.
	sz > szsqLong ifTrue:
		[^self primitiveFail].
	value := 0.
	0 to: sz - 1 do: [:i |
		value := value + ((self cCoerce: (self fetchByte: i ofObject: oop) to: #sqLong) <<  (i*8))].
	^value