compile abstract instructions
genClearAndSetSmallIntegerTagsIn: scratchReg
	"Set the SmallInteger tag bits when the tag bits may be filled with garbage."
	^self genSetSmallIntegerTagsIn: scratchReg