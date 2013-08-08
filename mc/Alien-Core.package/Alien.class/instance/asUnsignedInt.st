converting
asUnsignedInt "^<Integer>"
	"Answer an Integer created from the first <n> bytes of the receiver (where n = self class sizeofInt) interpreted as an unsigned value"
	
	^self unsignedIntAt: 1