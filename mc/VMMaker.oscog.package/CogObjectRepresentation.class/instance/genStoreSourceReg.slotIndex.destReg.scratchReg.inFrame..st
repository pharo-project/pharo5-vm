compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg inFrame: inFrame
	^ self 
		genStoreSourceReg: sourceReg 
		slotIndex: index 
		destReg: destReg 
		scratchReg: scratchReg 
		inFrame: inFrame 
		needsStoreCheck: true