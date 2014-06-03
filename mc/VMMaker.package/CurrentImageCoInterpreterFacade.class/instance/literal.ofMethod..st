accessing
literal: index ofMethod: anOop
	| lit |
	lit := (self objectForOop: anOop) literalAt: index + 1.
	^lit class == SmallInteger
		ifTrue: [objectMemory integerObjectOf: lit]
		ifFalse: [self oopForObject: lit]