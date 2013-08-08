primitive support
signed32BitIntegerFor: integerValue
	"Return a full 32 bit integer object for the given integer value"
	| newLargeInteger value largeClass |
	<inline: false>
	(objectMemory isIntegerValue: integerValue)
		ifTrue: [^ objectMemory integerObjectOf: integerValue].
	integerValue < 0
		ifTrue:[	largeClass := objectMemory classLargeNegativeInteger.
				value := 0 - integerValue]
		ifFalse:[	largeClass := objectMemory classLargePositiveInteger.
				value := integerValue].
	newLargeInteger := objectMemory eeInstantiateClass: largeClass indexableSize: 4.
	objectMemory storeByte: 3 ofObject: newLargeInteger withValue: ((value >> 24) bitAnd: 16rFF).
	objectMemory storeByte: 2 ofObject: newLargeInteger withValue: ((value >> 16) bitAnd: 16rFF).
	objectMemory storeByte: 1 ofObject: newLargeInteger withValue: ((value >> 8) bitAnd: 16rFF).
	objectMemory storeByte: 0 ofObject: newLargeInteger withValue: (value bitAnd: 16rFF).
	^newLargeInteger