immediates
integerValueOf: oop
	"Translator produces 'oop >> 1'"
	^(oop >> 31) = 1 "tests top bit"
		ifTrue: "negative"
			[((oop >> 1) bitAnd: 16r3FFFFFFF) - 16r3FFFFFFF - 1  "Faster than -16r40000000 (a LgInt)"]
		ifFalse: "positive"
			[oop >> 1]