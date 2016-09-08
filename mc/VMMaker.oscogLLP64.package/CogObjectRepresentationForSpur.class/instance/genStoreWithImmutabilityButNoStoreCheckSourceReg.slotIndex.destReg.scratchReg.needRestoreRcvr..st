compile abstract instructions
genStoreWithImmutabilityButNoStoreCheckSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg needRestoreRcvr: needRestoreRcvr
	"Gen an immutability check with no store check (e.g. assigning an immediate literal)"
	<option: #IMMUTABILITY>
	<var: #mutableJump type: #'AbstractInstruction *'>
	<var: #immutabilityFailure type: #'AbstractInstruction *'>
	| immutabilityFailure mutableJump |
	
	"imm check has its own trampoline"
	mutableJump := self genJumpMutable: destReg scratchReg: scratchReg.
	self genStoreTrampolineCall: index.
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