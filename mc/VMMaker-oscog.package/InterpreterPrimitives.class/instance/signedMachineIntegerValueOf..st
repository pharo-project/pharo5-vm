primitive support
signedMachineIntegerValueOf: oop
	"Answer a signed value of an integer up to the size of a machine word.
	The object may be either a positive SmallInteger or a LargeInteger of size <= word size."
	<returnTypeC: #'long'>
	| negative ok bs value bits |
	<var: #value type: #long>
	(objectMemory isIntegerObject: oop) ifTrue:
		[^objectMemory integerValueOf: oop].

	ok := objectMemory isClassOfNonImm: oop
					equalTo: (objectMemory splObj: ClassLargePositiveInteger)
					compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok
		ifTrue: [negative := false]
		ifFalse:
			[negative := true.
			 ok := objectMemory isClassOfNonImm: oop
							equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
							compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
			ok ifFalse: [^self primitiveFail]].
	(bs := objectMemory lengthOf: oop) > (self sizeof: #'unsigned long') ifTrue:
		[^self primitiveFail].

	((self sizeof: #'unsigned long') = 8
	 and: [bs > 4])
		ifTrue:
			[value :=   (objectMemory fetchByte: 0 ofObject: oop)
					+ ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
					+ ((objectMemory fetchByte: 2 ofObject: oop) << 16)
					+ ((objectMemory fetchByte: 3 ofObject: oop) << 24)
					+ ((objectMemory fetchByte: 4 ofObject: oop) << 32)
					+ ((objectMemory fetchByte: 5 ofObject: oop) << 40)
					+ ((objectMemory fetchByte: 6 ofObject: oop) << 48)
					+ ((objectMemory fetchByte: 7 ofObject: oop) << 56)]
		ifFalse:
			[value :=   (objectMemory fetchByte: 0 ofObject: oop)
					+ ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
					+ ((objectMemory fetchByte: 2 ofObject: oop) << 16)
					+ ((objectMemory fetchByte: 3 ofObject: oop) << 24)].

	
	self cCode: []
		inSmalltalk:
			[bits := (self sizeof: #long) * 8.
			 (value bitShift: 1 - bits) > 0 ifTrue:
				[value := value - (1 bitShift: bits)]].
	value < 0 ifTrue:
		["Don't fail for -16r80000000[00000000].
		  Alas the simple (negative and: [value - 1 > 0]) isn't adequate since in C the result of signed integer
		  overflow is undefined and hence under optimization this may fail.  The shift, however, is well-defined."
		 (negative and: [0 = (self cCode: [value << 1]
									inSmalltalk: [value << 1 bitAnd: (1 << bits) - 1])]) ifTrue: 
			[^value].
		 ^self primitiveFail].
	^negative
		ifTrue: [0 - value]
		ifFalse: [value]