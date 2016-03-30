compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg inFrame: inFrame
	<inline: true>
	self 
		cppIf: IMMUTABILITY
		ifTrue:
			[ ^ self 
				genStoreWithImmutabilityCheckSourceReg: sourceReg 
				slotIndex: index 
				destReg: destReg 
				scratchReg: scratchReg 
				needsStoreCheck: true 
				needRestoreRcvr: false "RcvrResultReg doesn't need to be live across the instructions" ]
		ifFalse: 
			[ ^ self 
				genStoreSourceReg: sourceReg 
				slotIndex: index 
				destReg: destReg 
				scratchReg: scratchReg 
				inFrame: inFrame 
				needsStoreCheck: true ]