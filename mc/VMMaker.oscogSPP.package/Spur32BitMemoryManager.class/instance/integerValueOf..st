immediates
integerValueOf: oop
	"Translator produces 'oop >> 1'"
	^(oop bitShift: -31) = 1 "tests top bit"
		ifTrue: "negative"
			[((oop bitShift: -1) bitAnd: 16r3FFFFFFF) - 16r3FFFFFFF - 1  "Faster than -16r40000000 (a LgInt)"]
		ifFalse: "positive"
			[oop bitShift: -1]