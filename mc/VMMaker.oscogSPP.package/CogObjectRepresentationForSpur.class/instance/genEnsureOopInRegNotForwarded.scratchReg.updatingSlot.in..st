compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch updatingSlot: index in: objReg
	"Make sure that the oop in reg is not forwarded, updating the slot in objReg with the value."
	| loop imm ok |
	<var: #ok type: #'AbstractInstruction *'>
	<var: #imm type: #'AbstractInstruction *'>
	<var: #loop type: #'AbstractInstruction *'>
	"Open-code
		self genEnsureOopInRegNotForwarded: reg
			scratchReg: scratch
			updatingMw: index * objectMemory wordSize + objectMemory baseHeaderSize
			r: objReg.
	 to avoid calling the store check unless the receiver is forwarded."
	self assert: (reg ~= scratch and: [objReg ~= scratch]).
	loop := cogit Label.
	imm := self genJumpImmediate: reg.
	"notionally
		self genGetClassIndexOfNonImm: reg into: scratch.
		cogit CmpCq: objectMemory isForwardedObjectClassIndexPun R: TempReg.
	 but the following is an instruction shorter:"
	cogit MoveMw: 0 r: reg R: scratch.
	cogit
		AndCq: objectMemory classIndexMask - objectMemory isForwardedObjectClassIndexPun
		R: scratch.
	ok := cogit JumpNonZero:  0.
	self genLoadSlot: 0 sourceReg: reg destReg: reg.
	cogit MoveR: reg Mw: index * objectMemory wordSize + objectMemory baseHeaderSize r: objReg.

	"Check that we're meeting the contract of ceStoreCheckContextReceiverTrampoline."
	self assert: (reg = Arg0Reg and: [scratch = TempReg and: [objReg = ReceiverResultReg]]).
	cogit CallRT: ceStoreCheckContextReceiverTrampoline.

	cogit Jump: loop.
	ok jmpTarget: (imm jmpTarget: cogit Label).
	^0