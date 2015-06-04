compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch updatingMw: offset r: baseReg
	"Make sure that the oop in reg is not forwarded, and the field reg[offset] is updated
	 if the object in reg is forwarded.  Use the fact that isForwardedObjectClassIndexPun is
	 a power of two to save an instruction."
	| loop imm ok |
	<var: #ok type: #'AbstractInstruction *'>
	<var: #imm type: #'AbstractInstruction *'>
	<var: #loop type: #'AbstractInstruction *'>
	self assert: (reg ~= scratch and: [baseReg ~= scratch]).
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
	cogit MoveR: reg Mw: offset r: baseReg.
	cogit Jump: loop.
	ok jmpTarget: (imm jmpTarget: cogit Label).
	^0