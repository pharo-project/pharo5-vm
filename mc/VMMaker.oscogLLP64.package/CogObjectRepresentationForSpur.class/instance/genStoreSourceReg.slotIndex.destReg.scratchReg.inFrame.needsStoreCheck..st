compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg inFrame: inFrame needsStoreCheck: needsStoreCheck
	
	cogit genTraceStores.
	"do the store"
	cogit MoveR: sourceReg
		   Mw: index * objectMemory wordSize + objectMemory baseHeaderSize
		   r: destReg.
	"now the check. needStoreCheck is false if the JIT has figured out that the value stored does not need the check (immediate, nil, true, false)"
	needsStoreCheck ifTrue: 
		[ ^ self 
			genStoreCheckReceiverReg: destReg 
			valueReg: sourceReg 
			scratchReg: scratchReg 
			inFrame: inFrame ].
	^ 0