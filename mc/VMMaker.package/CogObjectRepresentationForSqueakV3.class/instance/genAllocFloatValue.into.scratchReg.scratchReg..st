compile abstract instructions
genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2
	<returnTypeC: #'AbstractInstruction *'>
	| allocSize newFloatHeaderSansHash jumpFail |
	<var: #jumpFail type: #'AbstractInstruction *'>
	allocSize := BaseHeaderSize + (objectMemory sizeof: #double).
	newFloatHeaderSansHash := ((objectMemory classFloatCompactIndex << objectMemory compactClassFieldLSB
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
	cogit AndCq: HashMaskUnshifted << BytesPerWord R: scratch2.
	cogit LogicalShiftLeftCq: HashBitsOffset - BytesPerWord R: scratch2.
	cogit OrCq: newFloatHeaderSansHash R: scratch2.
	cogit MoveR: scratch2 Mw: 0 r: resultReg.
	cogit MoveRd: dpreg M64: BaseHeaderSize r: resultReg.
	cogit MoveR: scratch1 Aw: objectMemory freeStartAddress.
	^jumpFail