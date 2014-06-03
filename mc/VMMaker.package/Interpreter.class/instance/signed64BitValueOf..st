primitive support
signed64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive ST integer or a eight-byte LargeInteger."
	| sz value largeClass negative szsqLong |
	<inline: false>
	<returnTypeC: #sqLong>
	<var: #value type: #sqLong>
	(self isIntegerObject: oop) ifTrue: [^self cCoerce: (self integerValueOf: oop) to: #sqLong].
	largeClass := self fetchClassOfNonImm: oop.
	largeClass = self classLargePositiveInteger
		ifTrue:[negative := false]
		ifFalse:[largeClass = self classLargeNegativeInteger
					ifTrue:[negative := true]
					ifFalse:[^self primitiveFail]].
	szsqLong := self sizeof: #sqLong.
	sz := self lengthOf: oop.
	sz > szsqLong 
		ifTrue: [^ self primitiveFail].
	value := 0.
	0 to: sz - 1 do: [:i |
		value := value + ((self cCoerce: (self fetchByte: i ofObject: oop) to: #sqLong) <<  (i*8))].
	"Filter out values out of range for the signed interpretation such as
	16rFFFFFFFF... (positive w/ bit 64 set) and -16rFFFFFFFF... (negative w/ bit
	64 set). Since the sign is implicit in the class we require that the high bit of
	the magnitude is not set which is a simple test here.  Note that we have to
	handle the most negative 64-bit value -9223372036854775808 specially."
	self cCode: []
		inSmalltalk:
			[(value anyMask: 16r8000000000000000) ifTrue:
				[value := value - 16r10000000000000000]].
	value < 0 ifTrue:
		[self cCode:
			[self assert: (self sizeof: value) == 8.
			 self assert: (self sizeof: value << 1) == 8].
		"Don't fail for -9223372036854775808/-16r8000000000000000.
		 Alas the simple (negative and: [value - 1 > 0]) isn't adequate since in C the result of signed integer
		  overflow is undefined and hence under optimization this may fail.  The shift, however, is well-defined."
		 (negative and: [0 = (self cCode: [value << 1]
									inSmalltalk: [value << 1 bitAnd: (1 << 64) - 1])]) ifTrue: 
			[^value].
		 ^self primitiveFail].
	^negative
		ifTrue:[0 - value]
		ifFalse:[value]