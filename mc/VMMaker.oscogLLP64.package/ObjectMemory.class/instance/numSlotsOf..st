object access
numSlotsOf: obj
	"Answer the number of oop-sized elements in the given object.
	 Unlike lengthOf: this does not adjust the length of a context
	 by the stackPointer and so can be used e.g. by cloneContext:"
	<api>
	| header sz |
	header := self baseHeader: obj.
	sz := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
			ifTrue: [(self sizeHeader: obj) bitAnd: AllButTypeMask]
			ifFalse: [header bitAnd: SizeMask].
	^sz - self baseHeaderSize >> self shiftForWord