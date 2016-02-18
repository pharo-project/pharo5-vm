object access
fetchPointer: fieldIndex ofObject: objOop
	<api>
	^self longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)