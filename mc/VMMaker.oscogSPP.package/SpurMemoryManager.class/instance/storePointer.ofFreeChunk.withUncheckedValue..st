heap management
storePointer: fieldIndex ofFreeChunk: objOop withUncheckedValue: valuePointer

	self assert: (self isFreeObject: objOop).
	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer