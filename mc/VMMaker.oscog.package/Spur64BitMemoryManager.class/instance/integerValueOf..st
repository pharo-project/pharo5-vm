immediates
integerValueOf: oop
	"Translator produces 'oop >> 3'"
	^(oop >> 63) = 1 "tests top bit"
		ifTrue: "negative"
			[((oop >> self numTagBits) bitAnd: 16r1FFFFFFFFFFFFFFF) - 16r1FFFFFFFFFFFFFFF - 1  "Faster than -16r4000000000000000 (a LgInt)"]
		ifFalse: "positive"
			[oop >> self numTagBits]