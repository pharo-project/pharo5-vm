compile abstract instructions
genImmutableCheck: regHoldingObjectMutated slotIndex: index sourceReg: regHoldingValueToStore scratchReg: scratchReg popBoolean: popBoolean needRestoreRcvr: needRestoreRcvr
	| mutableJump fail |
	<var: #mutableJump type: #'AbstractInstruction *'>
	<var: #fail type: #'AbstractInstruction *'>
	<inline: true>
	<option: #IMMUTABILITY>
	"Trampoline convention: 
	- objectMutated passed in ReceiverResultReg
	- index (unboxed) passed in TempReg
	- valueToStore passed in ClassReg.
	Simulated stack is flushed, but if needRestoreRcvr is true 
	the receiver has to be live after this operation."
	self assert: regHoldingObjectMutated == ReceiverResultReg. 
	self assert: scratchReg == TempReg.
	self assert: regHoldingValueToStore == ClassReg.
	mutableJump := self genJumpMutable: ReceiverResultReg scratchReg: TempReg.
	
	"We reach this code if the object mutated is immutable."
	cogit MoveCq: index R: TempReg.
	"trampoline call and mcpc to bcpc annotation."
	cogit CallRT: ceCannotAssignToWithIndexTrampoline.
	cogit annotateBytecode: cogit Label.
	"restore ReceiverResultReg state if needed, the rest of the state is spilled"
	needRestoreRcvr ifTrue: [ cogit putSelfInReceiverResultReg ].
	fail := cogit Jump: 0.
	
	"We reach this code is the object mutated is mutable"
	mutableJump jmpTarget: cogit Label.
	
	^ fail