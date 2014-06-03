compile abstract instructions
genLoadSlot: index sourceReg: sourceReg destReg: destReg
	cogit
		MoveMw: index * objectMemory wordSize + objectMemory baseHeaderSize
		r: sourceReg
		R: destReg.
	^0