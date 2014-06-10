heap management
fetchPointer: fieldIndex ofMaybeForwardedObject: objOop
	^self longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)