compile abstract instructions
genStoreCheckReceiverReg: destReg valueReg: valueReg scratchReg: scratchReg inFrame: inFrame
	"Generate the code for a store check of valueReg into destReg."
	| jmpImmediate jmpDestYoung jmpSourceOld jmpAlreadyRemembered |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #jmpDestYoung type: #'AbstractInstruction *'>
	<var: #jmpSourceOld type: #'AbstractInstruction *'>
	<var: #jmpAlreadyRemembered type: #'AbstractInstruction *'>
	"Is value stored an immediate?  If so we're done"
	jmpImmediate := self genJumpImmediate: valueReg.
	"Get the old/new boundary in scratchReg"
	cogit MoveCw: objectMemory storeCheckBoundary R: scratchReg.
	"Is target young?  If so we're done"
	cogit CmpR: scratchReg R: destReg. "N.B. FLAGS := destReg - scratchReg"
	jmpDestYoung := cogit JumpBelow: 0.
	"Is value stored old?  If so we're done."
	cogit CmpR: scratchReg R: valueReg. "N.B. FLAGS := valueReg - scratchReg"
	jmpSourceOld := cogit JumpAboveOrEqual: 0.
	"value is young and target is old.
	 Need to remember this only if the remembered bit is not already set."
	CheckRememberedInTrampoline ifFalse:
		[jmpAlreadyRemembered := self genCheckRememberedBitOf: destReg scratch: scratchReg].
	"Remembered bit is not set.  Call store check to insert dest into remembered table."
	self assert: destReg = ReceiverResultReg.
	cogit 
		evaluateTrampolineCallBlock: [cogit CallRT: ceStoreCheckTrampoline]
		protectLinkRegIfNot: inFrame.
	jmpImmediate jmpTarget:
	(jmpDestYoung jmpTarget:
	(jmpSourceOld jmpTarget:
		cogit Label)).
	CheckRememberedInTrampoline ifFalse:
		[jmpAlreadyRemembered jmpTarget: jmpSourceOld getJmpTarget].
	^0