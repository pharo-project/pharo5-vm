compile abstract instructions
genStoreImmediateInSourceReg: sourceReg slotIndex: index destReg: destReg
	cogit MoveR: sourceReg
		   Mw: index * objectMemory wordSize + objectMemory baseHeaderSize
		   r: destReg.
	^0