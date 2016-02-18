compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch ifForwarder: fwdJumpTarget ifNotForwarder: nonFwdJumpTargetOrZero
	"Make sure that the oop in reg is not forwarded.  
	 Use the fact that isForwardedObjectClassIndexPun is a power of two to save an instruction."
	| imm ok finished |
	<inline: true>
	<var: #ok type: #'AbstractInstruction *'>
	<var: #imm type: #'AbstractInstruction *'>
	<var: #finished type: #'AbstractInstruction *'>
	self assert: reg ~= scratch.
	imm := self genJumpImmediate: reg.
	"notionally
		self genGetClassIndexOfNonImm: reg into: scratch.
		cogit CmpCq: objectMemory isForwardedObjectClassIndexPun R: TempReg.
	 but the following is an instruction shorter:"
	cogit MoveMw: 0 r: reg R: scratch.
	cogit
		AndCq: objectMemory classIndexMask - objectMemory isForwardedObjectClassIndexPun
		R: scratch.
	ok := cogit JumpNonZero: 0.
	self genLoadSlot: 0 sourceReg: reg destReg: reg.
	cogit Jump: fwdJumpTarget.
	finished := nonFwdJumpTargetOrZero = 0
		ifTrue: [ cogit Label ]
		ifFalse: [ self cCoerceSimple: nonFwdJumpTargetOrZero to: #'AbstractInstruction *' ].
	imm jmpTarget: (ok jmpTarget: finished).
	^0