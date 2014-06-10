compile abstract instructions
genStoreCheckReceiverReg: destReg valueReg: valueReg scratchReg: scratchReg
	"Generate the code for a store check of valueReg into destReg."
	| jmpImmediate jmpDestYoung jmpSourceOld jmpAlreadyRemembered mask rememberedBitByteOffset |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #jmpDestYoung type: #'AbstractInstruction *'>
	<var: #jmpSourceOld type: #'AbstractInstruction *'>
	<var: #jmpAlreadyRemembered type: #'AbstractInstruction *'>
	"Is value stored an integer?  If so we're done"
	cogit MoveR: valueReg R: scratchReg.
	cogit AndCq: objectMemory tagMask R: scratchReg.
	jmpImmediate := cogit JumpNonZero: 0.
	"Get the old/new boundary in scratchReg"
	cogit MoveCw: objectMemory storeCheckBoundary R: scratchReg.
	"Is target young?  If so we're done"
	cogit CmpR: scratchReg R: destReg. "N.B. FLAGS := destReg - scratchReg"
	jmpDestYoung := cogit JumpBelow: 0.
	"Is value stored old?  If so we're done."
	cogit CmpR: scratchReg R: valueReg. "N.B. FLAGS := valueReg - scratchReg"
	jmpSourceOld := cogit JumpAboveOrEqual: 0.
	"value is young and target is old.
	 Need to remember this only if the remembered bit is not already set.
	 Test the remembered bit.  Only need to fetch the byte containing it,
	 which reduces the size of the mask constant."
	rememberedBitByteOffset := jmpSourceOld isBigEndian
									ifTrue: [objectMemory baseHeaderSize - 1 - (objectMemory rememberedBitShift // 8)]
									ifFalse:[objectMemory rememberedBitShift // 8].
	mask := 1 << (objectMemory rememberedBitShift \\ 8).
	"N.B. MoveMb:r:R: does not zero other bits"
	cogit MoveMb: rememberedBitByteOffset r: destReg R: scratchReg.
	cogit AndCq: mask R: scratchReg.
	jmpAlreadyRemembered := cogit JumpNonZero: 0.
	"Remembered bit is not set.  Call store check to insert dest into remembered table."
	self assert: destReg == ReceiverResultReg.
	cogit
		CallRT: ceStoreCheckTrampoline
		registersToBeSavedMask: ((cogit registerMaskFor: valueReg)
										bitAnd: cogit callerSavedRegMask).
	jmpImmediate jmpTarget:
	(jmpDestYoung jmpTarget:
	(jmpSourceOld jmpTarget:
	(jmpAlreadyRemembered jmpTarget:
		cogit Label))).
	^0