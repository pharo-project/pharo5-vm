compile abstract instructions
genEnsureObjInRegNotForwarded: reg scratchReg: scratch
	"Make sure that the object in reg is not forwarded."
	| loop ok |
	<var: #ok type: #'AbstractInstruction *'>
	<var: #loop type: #'AbstractInstruction *'>
	self assert: reg ~= scratch.
	loop := cogit Label.
	self genGetClassIndexOfNonImm: reg into: scratch.
	cogit CmpCq: objectMemory isForwardedObjectClassIndexPun
		R: TempReg.
	ok := cogit JumpNonZero:  0.
	self genLoadSlot: 0 sourceReg: reg destReg: reg.
	cogit Jump: loop.
	ok jmpTarget: cogit Label.
	^0