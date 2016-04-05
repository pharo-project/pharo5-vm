primitive support
signed32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargeInteger."
	| value negative ok magnitude |
	<inline: false>
	<returnTypeC: #int>
	<var: #value type: #int>
	<var: #magnitude type: #'unsigned int'>
	<var: #value64 type: #long>
	(objectMemory isIntegerObject: oop) ifTrue:
		[objectMemory wordSize = 4
			ifTrue:
				[^objectMemory integerValueOf: oop]
			ifFalse: "Must fail for SmallIntegers with digitLength > 4"
				[| value64 |
				 value64 := objectMemory integerValueOf: oop.
				 (self cCode: [(self cCoerceSimple: value64 to: #int) ~= value64]
						inSmalltalk: [value64 >> 31 ~= 0 and: [value64 >> 31 ~= -1]]) ifTrue:
					[self primitiveFail. value64 := 0].
				 ^value64]].

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