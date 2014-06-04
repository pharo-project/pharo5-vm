primitive support
signed32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargeInteger."
	| value negative ok |
	<inline: false>
	<returnTypeC: #int>
	<var: #value type: #int>
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
	(objectMemory lengthOf: oop) > 4 ifTrue:
		[^self primitiveFail].

	value :=  (objectMemory fetchByte: 0 ofObject: oop) +
			  ((objectMemory fetchByte: 1 ofObject: oop) <<  8) +
			  ((objectMemory fetchByte: 2 ofObject: oop) << 16) +
			  ((objectMemory fetchByte: 3 ofObject: oop) << 24).
	self cCode: []
		inSmalltalk:
			[(value anyMask: 16r80000000) ifTrue:
				[value := value - 16r100000000]].
	"Filter out values out of range for the signed interpretation such as
	 16rFFFFFFFF (positive w/ bit 32 set) and -16rFFFFFFFF (negative w/ bit
	 32 set). Since the sign is implicit in the class we require that the high
	 bit of the magnitude is not set which is a simple test here.  Note that
	 we have to handle the most negative 32-bit value -2147483648 specially."
	value < 0 ifTrue:
		[self assert: (self sizeof: value) == 4.
		 "Don't fail for -16r80000000/-2147483648
		  Alas the simple (negative and: [value - 1 > 0]) isn't adequate since in C the result of signed integer
		  overflow is undefined and hence under optimization this may fail.  The shift, however, is well-defined."
		 (negative and: [0 = (self cCode: [value << 1]
									inSmalltalk: [value << 1 bitAnd: (1 << 32) - 1])]) ifTrue: 
			[^value].
		 ^self primitiveFail].
	^negative
		ifTrue: [0 - value]
		ifFalse: [value]