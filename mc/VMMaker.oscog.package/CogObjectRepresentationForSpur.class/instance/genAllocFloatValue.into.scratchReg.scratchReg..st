primitive generators
genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2
	<returnTypeC: #'AbstractInstruction *'>
	| allocSize newFloatHeader jumpFail |
	<var: #jumpFail type: #'AbstractInstruction *'>
	allocSize := objectMemory baseHeaderSize + (objectMemory sizeof: #double).
	newFloatHeader := objectMemory
							headerForSlots: (self sizeof: #double) / objectMemory wordSize
							format: objectMemory firstLongFormat
							classIndex: ClassFloatCompactIndex.
	cogit MoveAw: objectMemory freeStartAddress R: resultReg.
	cogit LoadEffectiveAddressMw: allocSize r: resultReg R: scratch1.
	cogit CmpCq: objectMemory getScavengeThreshold R: scratch1.
	jumpFail := cogit JumpAboveOrEqual: 0.
	cogit MoveR: scratch1 Aw: objectMemory freeStartAddress.
	self genStoreHeader: newFloatHeader intoNewInstance: resultReg using: scratch1.
	cogit MoveRd: dpreg M64: objectMemory baseHeaderSize r: resultReg.
	^jumpFail