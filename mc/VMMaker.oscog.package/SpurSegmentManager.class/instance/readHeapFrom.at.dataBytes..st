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
			[(f	readInto: manager memory
				startingAt: location // 4 + 1
				count: numBytes // 4)
			 * 4]