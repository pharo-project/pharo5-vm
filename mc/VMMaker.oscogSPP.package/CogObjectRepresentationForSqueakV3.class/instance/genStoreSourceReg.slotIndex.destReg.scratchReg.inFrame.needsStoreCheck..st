compile abstract instructions
genStoreSourceReg: sourceReg slotIndex: index destReg: destReg scratchReg: scratchReg inFrame: inFrame needsStoreCheck: needsStoreCheck
	| jmpImmediate jmpDestYoung jmpSourceOld jmpAlreadyRoot mask rootBitByteOffset |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #jmpDestYoung type: #'AbstractInstruction *'>
	<var: #jmpSourceOld type: #'AbstractInstruction *'>
	<var: #jmpAlreadyRoot type: #'AbstractInstruction *'>
	
	cogit genTraceStores.
	"do the store"
	cogit MoveR: sourceReg Mw: index * objectMemory wordSize + objectMemory baseHeaderSize r: destReg.
	"if no need for the store check then returns"
	needsStoreCheck ifFalse: [ ^ 0 ].
	"now the check.  Is value stored an integer?  If so we're done"
	jmpImmediate := self genJumpImmediate: sourceReg.
	"Get the old/new boundary in scratchReg"
	cogit MoveAw: objectMemory youngStartAddress R: scratchReg.
	"Is target young?  If so we're done"
	cogit CmpR: scratchReg R: destReg. "N.B. FLAGS := destReg - scratchReg"
	jmpDestYoung := cogit JumpAboveOrEqual: 0.
	"Is value stored old?  If so we're done."
	cogit CmpR: scratchReg R: sourceReg. "N.B. FLAGS := sourceReg - scratchReg"
	jmpSourceOld := cogit JumpBelow: 0.
	"value is young and target is old.
	 Need to make this a root if the root bit is not already set.
	 Test the root bit.  Only need to fetch the byte containing it,
	 which reduces the size of the mask constant."
	rootBitByteOffset := jmpSourceOld isBigEndian
							ifTrue: [objectMemory wordSize - RootBitDigitLength]
							ifFalse:[RootBitDigitLength - 1].
	mask := RootBitDigitLength > 1
				ifTrue: [RootBit >> (RootBitDigitLength - 1 * 8)]
				ifFalse: [RootBit].
	cogit MoveMb: rootBitByteOffset r: destReg R: scratchReg.
	cogit AndCq: mask R: scratchReg.
	jmpAlreadyRoot := cogit JumpNonZero: 0.
	"Root bit is not set.  Call store check to insert dest into root table."
	self assert: destReg == ReceiverResultReg.
	cogit 
		evaluateTrampolineCallBlock: [cogit CallRT: ceStoreCheckTrampoline]
		protectLinkRegIfNot: inFrame.
	jmpImmediate jmpTarget:
	(jmpDestYoung jmpTarget:
	(jmpSourceOld jmpTarget:
	(jmpAlreadyRoot jmpTarget:
		cogit Label))).
	^0