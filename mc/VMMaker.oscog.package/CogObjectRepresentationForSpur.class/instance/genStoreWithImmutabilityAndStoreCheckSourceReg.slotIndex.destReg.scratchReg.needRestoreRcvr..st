compile abstract instructions
genStoreWithImmutabilityAndStoreCheckSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg needRestoreRcvr: needRestoreRcvr 
	"Store check code is duplicated to use a single trampoline"
	<var: #immutableJump type: #'AbstractInstruction *'>
	<var: #trampJump type: #'AbstractInstruction *'>
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #jmpDestYoung type: #'AbstractInstruction *'>
	<var: #jmpSourceOld type: #'AbstractInstruction *'>
	<var: #jmpAlreadyRemembered type: #'AbstractInstruction *'>
	| immutableJump trampJump jmpImmediate jmpDestYoung jmpSourceOld rememberedBitByteOffset jmpAlreadyRemembered mask |
	
	immutableJump := self genJumpImmutable: destReg scratchReg: scratchReg.
	
	cogit genTraceStores.
	
	"do the store"
	cogit MoveR: sourceReg
		   Mw: index * objectMemory wordSize + objectMemory baseHeaderSize
		   r: destReg.
	
	"store check"
	jmpImmediate := self genJumpImmediate: sourceReg.
	"Get the old/new boundary in scratchReg"
	cogit MoveCw: objectMemory storeCheckBoundary R: scratchReg.
	"Is target young?  If so we're done"
	cogit CmpR: scratchReg R: destReg. "N.B. FLAGS := destReg - scratchReg"
	jmpDestYoung := cogit JumpBelow: 0.
	"Is value stored old?  If so we're done."
	cogit CmpR: scratchReg R: sourceReg. "N.B. FLAGS := valueReg - scratchReg"
	jmpSourceOld := cogit JumpAboveOrEqual: 0.
	"value is young and target is old.
	 Need to remember this only if the remembered bit is not already set.
	 Test the remembered bit.  Only need to fetch the byte containing it,
	 which reduces the size of the mask constant."
	rememberedBitByteOffset := jmpSourceOld isBigEndian
									ifTrue: [objectMemory baseHeaderSize - 1 - (objectMemory rememberedBitShift // 8)]
									ifFalse:[objectMemory rememberedBitShift // 8].
	mask := 1 << (objectMemory rememberedBitShift \\ 8).
	cogit MoveMb: rememberedBitByteOffset r: destReg R: scratchReg.
	cogit AndCq: mask R: scratchReg.
	jmpAlreadyRemembered := cogit JumpNonZero: 0.
	"We know scratchReg now holds 0, this is convenient because the trampoline 
	convention expects 0 for store check in scratchReg. What a coincidence ;-)"
	"Remembered bit is not set.  Call store check to insert dest into remembered table."
	trampJump := cogit Jump: 0.
	"Here we reach the trampoline for Immutability failure"
	immutableJump jmpTarget: (cogit MoveCq: index + 1 R: scratchReg). "index + 1 as 0 is reserved for store checks"
	trampJump jmpTarget: (cogit CallRT: ceStoreTrampoline).
	cogit annotateBytecode: cogit Label.
	needRestoreRcvr ifTrue: [ cogit putSelfInReceiverResultReg ].

	jmpImmediate jmpTarget:
	(jmpDestYoung jmpTarget:
	(jmpSourceOld jmpTarget:
	(jmpAlreadyRemembered jmpTarget:
		cogit Label))).
	
	^ 0