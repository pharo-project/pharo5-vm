converting
integerObjectOf: value
	value class == SmallInteger ifFalse:[self error:'Not a SmallInteger object'].
	^value