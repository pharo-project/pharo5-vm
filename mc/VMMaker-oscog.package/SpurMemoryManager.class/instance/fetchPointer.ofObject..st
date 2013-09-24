object access
fetchPointer: fieldIndex ofObject: objOop
	self assert: (self isForwarded: objOop) not.
	^self longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)