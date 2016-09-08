heap management
storePointer: fieldIndex ofFreeChunk: objOop withValue: valuePointer

	self assert: (self isFreeObject: objOop).
	self assert: (valuePointer = 0 or: [self isFreeObject: valuePointer]).

	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer