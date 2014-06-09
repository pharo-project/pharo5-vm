compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch
	"Make sure that the oop in reg is not forwarded."
	| loop okImm okObj |
	<var: #okImm type: #'AbstractInstruction *'>
	<var: #okObj type: #'AbstractInstruction *'>
	<var: #loop type: #'AbstractInstruction *'>
	self assert: reg ~= scratch.
	loop := cogit MoveR: reg R: scratch.
	okImm := self genJumpImmediateInScratchReg: scratch.
	"notionally
		self genGetClassIndexOfNonImm: reg into: scratch.
		cogit CmpCq: objectMemory isForwardedObjectClassIndexPun R: TempReg.
	 but the following is an instruction shorter:"
	cogit MoveMw: 0 r: reg R: scratch.
	cogit
		AndCq: objectMemory classIndexMask - objectMemory isForwardedObjectClassIndexPun
		R: scratch.
	okObj := cogit JumpNonZero:  0.
	self genLoadSlot: 0 sourceReg: reg destReg: reg.
	cogit Jump: loop.
	okImm jmpTarget: (okObj jmpTarget: cogit Label).
	^0