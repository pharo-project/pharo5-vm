object access
sizeBitsOfSafe: oop
	"Compute the size of the given object from the cc and size fields in its header.
	 This works even if its type bits are not correct."

	| header type |
	header := self baseHeader: oop.
	type := self rightType: header.
	^type = HeaderTypeSizeAndClass
		ifTrue: [(self sizeHeader: oop) bitAnd: AllButTypeMask]
		ifFalse: [header bitAnd: SizeMask]