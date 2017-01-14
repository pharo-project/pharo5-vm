object access
sizeBitsOf: oop
	"Answer the number of bytes in the given object, including its base header, rounded up to an integral number of words."
	"Note: byte indexable objects need to have low bits subtracted from this size."

	| header |
	header := self baseHeader: oop.
	(header bitAnd: TypeMask) = HeaderTypeSizeAndClass
		ifTrue: [ ^ (self sizeHeader: oop) bitAnd: LongSizeMask ]
		ifFalse: [ ^ header bitAnd: SizeMask ].