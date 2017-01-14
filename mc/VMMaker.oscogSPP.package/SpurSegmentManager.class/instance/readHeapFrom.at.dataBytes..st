private
readHeapFrom: f at: location dataBytes: numBytes
	"Read numBytes from f into mmory at location.  Answer the number of bytes read."
	^self cCode:
			[self
				sq: (self pointerForOop: location)
				Image: (self sizeof: #char)
				File: numBytes
				Read: f]
		inSmalltalk:
			[| bytesPerElement |
			 bytesPerElement := manager memory bytesPerElement.
			 (f	readInto: manager memory
				startingAt: location // bytesPerElement + 1
				count: numBytes // bytesPerElement)
			  * bytesPerElement]