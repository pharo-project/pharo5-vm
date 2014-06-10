compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index intoNewObjectInDestReg: destReg
	cogit MoveR: sourceReg Mw: index * BytesPerWord + BaseHeaderSize r: destReg.
	^0