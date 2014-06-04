free space
sizeOfFree: objOop
	"For compatibility with ObjectMemory, answer the size of a free chunk in bytes.
	 Do *not* use internally."
	self assert: (self isFreeObject: objOop).
	^self bytesInObject: objOop