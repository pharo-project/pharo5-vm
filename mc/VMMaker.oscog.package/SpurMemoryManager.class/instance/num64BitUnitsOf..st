object access
num64BitUnitsOf: objOop 
	"Answer the number of 16-bit units in the given non-immediate object.
	 N..B. Rounds down 8-bit units, so a 15 byte object has 1 64-bit unit.
	 Does not adjust the size of contexts by stackPointer."
	^(self numBytesOf: objOop) >> 3