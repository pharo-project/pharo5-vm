sista support
branchIf: reg hasImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate|
	<inline: true>
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpSmallInteger: reg].
	classIndex = objectMemory characterTag ifTrue:
		[cogit MoveR: reg R: TempReg.
		 jmpImmediate := self genJumpCharacterInScratchReg: reg].
	jmpImmediate jmpTarget: targetFixUp