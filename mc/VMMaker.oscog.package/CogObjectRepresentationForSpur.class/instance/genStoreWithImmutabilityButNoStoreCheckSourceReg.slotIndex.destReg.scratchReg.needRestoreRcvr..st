compile abstract instructions
genStoreWithImmutabilityButNoStoreCheckSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg needRestoreRcvr: needRestoreRcvr

	<var: #immutableJump type: #'AbstractInstruction *'>
	<var: #immutabilityFailure type: #'AbstractInstruction *'>
	| immutabilityFailure mutableJump |
	
	"imm check has its own trampoline"
	mutableJump := self genJumpMutable: destReg scratchReg: scratchReg.
	cogit MoveCq: index + 1 R: TempReg. "index + 1 as 0 is reserved for store checks"
	cogit CallRT: ceStoreTrampoline.
	cogit annotateBytecode: cogit Label.
	needRestoreRcvr ifTrue: [ cogit putSelfInReceiverResultReg ].
	immutabilityFailure := cogit Jump: 0.
	mutableJump jmpTarget: cogit Label.

	cogit genTraceStores.
	
	"do the store"
	cogit MoveR: sourceReg
		   Mw: index * objectMemory wordSize + objectMemory baseHeaderSize
		   r: destReg.
		
	immutabilityFailure jmpTarget: cogit Label.

	^ 0