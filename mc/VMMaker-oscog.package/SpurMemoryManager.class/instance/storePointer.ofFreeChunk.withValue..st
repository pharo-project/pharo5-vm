heap management
storePointer: fieldIndex ofFreeChunk: objOop withValue: valuePointer

	self assert: (self isFreeObject: objOop).

	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer