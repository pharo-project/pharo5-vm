compile abstract instructions
genGetClassObjectOfClassIndex: instReg into: destReg scratchReg: scratchReg
	"Fetch the class object whose index is in instReg into destReg.
	 It is non-obvious, but the Cogit assumes loading a class does not involve
	 a runtime call, so do not call classAtIndex:"
	self assert: instReg ~= destReg.
	self assert: instReg ~= scratchReg.
	self assert: destReg ~= scratchReg.
	cogit
		MoveR: instReg R: scratchReg;
		LogicalShiftRightCq: objectMemory classTableMajorIndexShift R: scratchReg;
		LogicalShiftLeftCq: objectMemory shiftForWord R: scratchReg.
	self assert: (self shouldAnnotateObjectReference: objectMemory classTableRootObj) not.
	(cogit backEnd isWithinMwOffsetRange: objectMemory classTableRootObj + objectMemory baseHeaderSize)
		ifTrue: [cogit MoveMw: objectMemory classTableRootObj + objectMemory baseHeaderSize r: scratchReg R: destReg]
		ifFalse: [cogit
					AddCq: objectMemory classTableRootObj R: scratchReg;
					MoveMw: objectMemory baseHeaderSize r: scratchReg R: destReg].
	cogit
		MoveR: instReg R: scratchReg;
		AndCq: objectMemory classTableMinorIndexMask R: scratchReg;
		AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: scratchReg;
		MoveXwr: scratchReg R: destReg R: destReg.
	^0