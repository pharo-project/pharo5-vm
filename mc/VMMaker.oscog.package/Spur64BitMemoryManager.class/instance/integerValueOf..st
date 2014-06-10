immediates
integerValueOf: oop
	"Translator produces 'oop >> 1'"
	^(oop bitShift: -63) = 1 "tests top bit"
		ifTrue: "negative"
			[((oop bitShift: self numTagBits negated) bitAnd: 16r3FFFFFFFFFFFFFFF) - 16r3FFFFFFFFFFFFFFF - 1  "Faster than -16r4000000000000000 (a LgInt)"]
		ifFalse: "positive"
			[oop bitShift: self numTagBits negated]