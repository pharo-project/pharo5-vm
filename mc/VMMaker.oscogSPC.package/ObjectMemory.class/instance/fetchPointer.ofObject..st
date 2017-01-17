object access
fetchPointer: fieldIndex ofObject: oop
	"index by word size, and return a pointer as long as the word size"
	<api>
	^self longAt: oop + self baseHeaderSize + (fieldIndex << self shiftForWord)