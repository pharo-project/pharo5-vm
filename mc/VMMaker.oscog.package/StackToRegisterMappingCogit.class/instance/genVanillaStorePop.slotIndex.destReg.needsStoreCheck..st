bytecode generator support
genVanillaStorePop: popBoolean slotIndex: slotIndex destReg: destReg needsStoreCheck: needsStoreCheck
	<inline: true>
	| topReg |
	topReg := self 
		allocateRegForStackEntryAt: 0 
		notConflictingWith: (self registerMaskFor: destReg). 
	self ssStorePop: popBoolean toReg: topReg.
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: destReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needsStoreCheck.