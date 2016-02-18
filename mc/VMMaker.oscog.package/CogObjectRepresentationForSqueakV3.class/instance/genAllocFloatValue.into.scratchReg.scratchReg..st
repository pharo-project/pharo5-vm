compile abstract instructions
genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2
	<returnTypeC: #'AbstractInstruction *'>
	| allocSize newFloatHeaderSansHash jumpFail |
	<var: #jumpFail type: #'AbstractInstruction *'>
	allocSize := objectMemory baseHeaderSize + (objectMemory sizeof: #double).
	newFloatHeaderSansHash := ((ClassFloatCompactIndex << objectMemory compactClassFieldLSB
									bitOr: (objectMemory formatOfClass: objectMemory classFloat))
									bitOr: allocSize)
									 bitOr: HeaderTypeShort.
	cogit MoveAw: objectMemory freeStartAddress R: resultReg.
	cogit MoveR: resultReg R: scratch1.
	cogit AddCq: allocSize R: scratch1.
	cogit MoveAw: objectMemory scavengeThresholdAddress R: scratch2.
	cogit CmpR: scratch2 R: scratch1.
	jumpFail := cogit JumpAboveOrEqual: 0.
	cogit MoveR: resultReg R: scratch2.
	self flag: #newObjectHash.
	cogit AndCq: HashMaskUnshifted << objectMemory wordSize R: scratch2.
	cogit LogicalShiftLeftCq: HashBitsOffset - objectMemory wordSize R: scratch2.
	cogit OrCq: newFloatHeaderSansHash R: scratch2.
	cogit MoveR: scratch2 Mw: 0 r: resultReg.
	cogit MoveRd: dpreg M64: objectMemory baseHeaderSize r: resultReg.
	cogit MoveR: scratch1 Aw: objectMemory freeStartAddress.
	^jumpFail