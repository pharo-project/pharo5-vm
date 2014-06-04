heap management
fetchPointer: fieldIndex ofFreeChunk: objOop
	^self longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)