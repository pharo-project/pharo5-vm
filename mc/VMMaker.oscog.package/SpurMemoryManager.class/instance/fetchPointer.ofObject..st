object access
fetchPointer: fieldIndex ofObject: objOop
	^self longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)