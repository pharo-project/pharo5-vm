compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg
	"do the store"
	cogit MoveR: sourceReg
		   Mw: index * objectMemory wordSize + objectMemory baseHeaderSize
		   r: destReg.
	"now the check"
	^self genStoreCheckReceiverReg: destReg valueReg: sourceReg scratchReg: scratchReg