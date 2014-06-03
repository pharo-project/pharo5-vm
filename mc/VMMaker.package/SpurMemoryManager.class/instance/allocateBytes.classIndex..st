allocation
allocateBytes: numBytes classIndex: classIndex
	"Allocate an object of numBytes.  Answer nil if no available memory.
	 classIndex must be that of a byte class (e.g. ByteString).
	 The object is *NOT FILLED*."
	self assert: (coInterpreter addressCouldBeClassObj: (self classAtIndex: classIndex)).
	self assert: (self instSpecOfClass: (self classAtIndex: classIndex)) = self firstByteFormat.
	^self
		allocateSlots: (numBytes + self bytesPerSlot - 1 // self bytesPerSlot)
		format: (self byteFormatForNumBytes: numBytes)
		classIndex: classIndex