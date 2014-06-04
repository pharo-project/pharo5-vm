primitive generators
genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2
	<returnTypeC: #'AbstractInstruction *'>
	| allocSize newFloatHeader jumpFail |
	<var: #jumpFail type: #'AbstractInstruction *'>
	allocSize := objectMemory baseHeaderSize + (objectMemory sizeof: #double).
	newFloatHeader := objectMemory
							headerForSlots: (self sizeof: #double) / objectMemory wordSize
							format: objectMemory firstLongFormat
							classIndex: objectMemory classFloatCompactIndex.
	cogit MoveAw: objectMemory freeStartAddress R: resultReg.
	cogit LoadEffectiveAddressMw: allocSize r: resultReg R: scratch1.
	cogit CmpCq: objectMemory getScavengeThreshold R: scratch1.
	jumpFail := cogit JumpAboveOrEqual: 0.
	cogit MoveR: scratch1 Aw: objectMemory freeStartAddress.
	cogit MoveCq: newFloatHeader R: scratch2.
	objectMemory wordSize = objectMemory baseHeaderSize
		ifTrue: [cogit MoveR: scratch2 Mw: 0 r: resultReg]
		ifFalse:
			[self flag: #endianness.
			 cogit MoveCq: newFloatHeader >> 32 R: scratch1.
			 cogit MoveR: scratch2 Mw: 0 r: resultReg.
			 cogit MoveR: scratch1 Mw: objectMemory wordSize r: resultReg].
	cogit MoveRd: dpreg M64: objectMemory baseHeaderSize r: resultReg.
	^jumpFail