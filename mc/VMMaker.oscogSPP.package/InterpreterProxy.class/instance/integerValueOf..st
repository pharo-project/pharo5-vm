converting
integerValueOf: oop
	oop class == SmallInteger ifFalse:[self error:'Not a SmallInteger'].
	^oop