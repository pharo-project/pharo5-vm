compile abstract instructions
genStoreImmediateInSourceReg: sourceReg slotIndex: index destReg: destReg
	cogit MoveR: sourceReg Mw: index * BytesPerWord + BaseHeaderSize r: destReg.
	^0