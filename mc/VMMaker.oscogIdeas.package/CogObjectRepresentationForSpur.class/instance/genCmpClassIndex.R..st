in-line cacheing
genCmpClassIndex: classIndex R: reg
	"It is safe to use a short comparison for the known classes; these will not
	 change with become, etc... But it's probably not safe to assume the hash of
	 some other class won't change over time, so to be sure of generating the
	 same size code over time, use a long comparison for unknown classes."
	classIndex < objectMemory classTablePageSize
		ifTrue: [cogit CmpCq: classIndex R: TempReg]
		ifFalse: [cogit CmpCw: classIndex R: TempReg]