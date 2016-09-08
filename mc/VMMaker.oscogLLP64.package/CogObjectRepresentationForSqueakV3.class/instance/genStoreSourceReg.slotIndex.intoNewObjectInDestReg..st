compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index intoNewObjectInDestReg: destReg
	cogit MoveR: sourceReg Mw: index * objectMemory wordSize + objectMemory baseHeaderSize r: destReg.
	^0