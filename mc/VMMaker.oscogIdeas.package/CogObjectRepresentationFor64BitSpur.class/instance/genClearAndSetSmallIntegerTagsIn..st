compile abstract instructions
genClearAndSetSmallIntegerTagsIn: scratchReg
	"Set the SmallInteger tag bits when the tag bits may be filled with garbage."
	cogit
		AndCq: -1 - objectMemory tagMask R: scratchReg;
		OrCq: 1 R: scratchReg.
	^0