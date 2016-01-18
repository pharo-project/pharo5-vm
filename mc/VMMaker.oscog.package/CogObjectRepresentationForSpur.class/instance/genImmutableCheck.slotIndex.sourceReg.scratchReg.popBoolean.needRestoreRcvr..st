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
	Simulated stack is flushed until simulatedStackPointer - 1, which implies full flush 
	if popBoolean is true, else top value may not be flushed.
	We spill the top value (the value to store) for the trampoline if needed."
	self assert: regHoldingObjectMutated == ReceiverResultReg. 
	self assert: scratchReg == TempReg.
	self assert: regHoldingValueToStore == ClassReg.
	mutableJump := self genJumpMutable: ClassReg scratchReg: TempReg.
	
	"We reach this code if the object mutated is immutable."
	"simulatedStack state altered for the trampoline, spill top value if needed"
	(popBoolean or: [ cogit ssTop spilled ]) ifFalse:
		[ self assert: (cogit ssTop type = SSRegister and: [cogit ssTop register = ClassReg]).
		  cogit PushR: ClassReg ].
	"pass the unboxed index using TempReg"
	cogit MoveCq: index R: TempReg.
	"trampoline call and mcpc to bcpc annotation."
	cogit CallRT: ceCannotAssignToWithIndexTrampoline.
	cogit annotateBytecode: cogit Label.
	"Top of stack is consumed by the trampoline. In case of store with non spilled value, 
	restore ClassReg to match simulated stack state"
	(popBoolean or: [ cogit ssTop spilled ]) ifFalse:
		[cogit popR: ClassReg].
	"restore ReceiverResultReg state if needed"
	needRestoreRcvr ifTrue: [ cogit putSelfInReceiverResultReg ].
	fail := cogit Jump: 0.
	
	"We reach this code is the object mutated is mutable"
	mutableJump jmpTarget: cogit Label.
	
	^ fail