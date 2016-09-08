sista support
branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate|
	<inline: true>
	cogit MoveR: reg R: TempReg.
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpNotSmallIntegerInScratchReg: TempReg].
	classIndex = objectMemory characterTag ifTrue:
		[jmpImmediate := self genJumpNotCharacterInScratchReg: TempReg].
	classIndex = objectMemory smallFloatTag ifTrue:
		[jmpImmediate := self genJumpNotSmallFloatInScratchReg: TempReg].
	jmpImmediate jmpTarget: targetFixUp