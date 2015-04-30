sista support
branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp
	| jmpImmediate|
	<inline: true>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	cogit MoveR: reg R: TempReg.
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpNotSmallIntegerInScratchReg: TempReg].
	classIndex = objectMemory characterTag ifTrue:
		[jmpImmediate := self genJumpNotCharacterInScratchReg: TempReg].
	jmpImmediate jmpTarget: targetFixUp