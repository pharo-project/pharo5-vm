compile abstract instructions
genConvertSmallFloatToSmallFloatHashAsIntegerInReg: reg scratch: scratch
	"Convert the SmallFloat in reg to its identityHash as a SmallInteger.
	 Rotate the sign bit from bit 3 (zero-relative) to the sign bit.  
	 c.f. Spur64BitMemoryManager>>rotatedFloatBitsOf:"
	self assert: objectMemory smallFloatTag >> 1 - objectMemory smallIntegerTag = objectMemory smallIntegerTag.
	cogit
		LogicalShiftRightCq: 1 R: reg;
		AndCq: 1 << (objectMemory numTagBits - 1) R: reg R: scratch;
		SubR: scratch R: reg;
		SubCq: objectMemory smallFloatTag >> 1 - objectMemory smallIntegerTag R: reg;
		LogicalShiftLeftCq: 63 - (objectMemory numTagBits - 1) R: scratch;
		OrR: scratch R: reg.
	^0