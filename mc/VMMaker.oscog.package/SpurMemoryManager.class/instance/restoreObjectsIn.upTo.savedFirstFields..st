image segment in/out
restoreObjectsIn: objArray upTo: limitOrTag savedFirstFields: savedFirstFields
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Enumerate the objects in objArray, unmarking them and restoring their saved first fields
	 from the corresponding slot in savedFirstFields.  The first unused entry in
	 objArray will have a non-hash value entry in savedHashes.  Free savedFirstFields."
	<inline: true>
	| numSlots |
	numSlots := limitOrTag = -1 ifTrue: [self numSlotsOf: objArray] ifFalse: [limitOrTag].
	0 to: numSlots - 1 do:
		[:i| | oop |
		oop := self fetchPointer: i ofObject: objArray.
		self storePointerUnchecked: 0 ofObject: oop withValue: (self fetchPointer: i ofObject: savedFirstFields).
		self setIsMarkedOf: oop to: false].
	(self isInOldSpace: savedFirstFields) ifTrue:
		[self freeObject: savedFirstFields]