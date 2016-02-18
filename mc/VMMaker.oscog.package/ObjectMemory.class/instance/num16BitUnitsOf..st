object access
num16BitUnitsOf: objOop 
	"Answer the number of 16-bit units in the given non-immediate object.
	 N..B. Rounds down 8-bit units, so a 5 byte object has 2 16-bit units.
	 Does not adjust the size of contexts by stackPointer."
	^(self numBytesOf: objOop) >> 1