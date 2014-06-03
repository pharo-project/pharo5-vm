heap management
storePointerNoAssert: fieldIndex ofFreeChunk: objOop withValue: valuePointer

	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer