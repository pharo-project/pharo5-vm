interpreter access
storePointer: fieldIndex ofObject: oop withValue: valuePointer
	"Note must check here for stores of young objects into old ones."

	(self oop: oop isLessThan: youngStart) ifTrue: [
		self possibleRootStoreInto: oop value: valuePointer.
	].

	^ self longAt: oop + BaseHeaderSize + (fieldIndex << ShiftForWord)
		put: valuePointer