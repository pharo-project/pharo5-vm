sista support
branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate |
	<inline: true>
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpNotSmallInteger: reg].
	classIndex = objectMemory characterTag ifTrue:
		[cogit MoveR: reg R: TempReg.
		 jmpImmediate := self genJumpNotCharacterInScratchReg: reg].
	jmpImmediate jmpTarget: targetFixUp