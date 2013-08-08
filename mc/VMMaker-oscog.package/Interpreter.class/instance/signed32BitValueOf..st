primitive support
signed32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive ST integer or a four-byte LargeInteger."
	| sz value largeClass negative |
	<inline: false>
	<returnTypeC: #int>
	<var: #value type: #int>
	(self isIntegerObject: oop) ifTrue: [^self integerValueOf: oop].
	largeClass := self fetchClassOf: oop.
	largeClass = self classLargePositiveInteger
		ifTrue:[negative := false]
		ifFalse:[largeClass = self classLargeNegativeInteger
					ifTrue:[negative := true]
					ifFalse:[^self primitiveFail]].
	sz := self lengthOf: oop.
	sz = 4 ifFalse: [^ self primitiveFail].
	value := (self fetchByte: 0 ofObject: oop) +
			  ((self fetchByte: 1 ofObject: oop) <<  8) +
			  ((self fetchByte: 2 ofObject: oop) << 16) +
			  ((self fetchByte: 3 ofObject: oop) << 24).
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