C library simulation
asString: stringIndex size: stringSize
	"stringIndex is an address in the heap.  Create a String of the requested length
	form the bytes in the heap starting at stringIndex."
	<doNotGenerate>
	^self st: (ByteString new: stringSize) rn: stringIndex cpy: stringSize