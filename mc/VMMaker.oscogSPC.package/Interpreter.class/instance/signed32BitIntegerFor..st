primitive support
signed32BitIntegerFor: integerValue
	"Return a full 32 bit integer object for the given integer value"
	| newLargeInteger value largeClass |
	<inline: false>
	(self isIntegerValue: integerValue)
		ifTrue: [^ self integerObjectOf: integerValue].
	integerValue < 0
		ifTrue:[	largeClass := self classLargeNegativeInteger.
				value := 0 - integerValue]
		ifFalse:[	largeClass := self classLargePositiveInteger.
				value := integerValue].
	newLargeInteger := self instantiateClass: largeClass indexableSize: 4.
	self storeByte: 3 ofObject: newLargeInteger withValue: ((value >> 24) bitAnd: 16rFF).
	self storeByte: 2 ofObject: newLargeInteger withValue: ((value >> 16) bitAnd: 16rFF).
	self storeByte: 1 ofObject: newLargeInteger withValue: ((value >> 8) bitAnd: 16rFF).
	self storeByte: 0 ofObject: newLargeInteger withValue: (value bitAnd: 16rFF).
	^ newLargeInteger