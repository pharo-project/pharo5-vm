instance creation
newGC: byteSize
	"Answer a new instance of the given byte size whose data resides on the external C heap,
	 and whose dsata will be reclaimed automatically when the instance is garbage collected.
	 As with instances residing on the Smalltalk heap the data is zero-filled."
	| alien address |
	(alien := self basicNew: self sizeofLong + self sizeofPointer)
		sizeFieldPut: byteSize negated.
	address := self Ccalloc: byteSize.
	GCMallocedAliens add: alien finalizing: address.
	^alien
		addressFieldPut: address;
		initialize