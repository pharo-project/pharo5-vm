sista support
branchIf: reg hasImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate|
	<inline: true>
	cogit MoveR: reg R: TempReg.
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg].
	classIndex = objectMemory characterTag ifTrue:
		[jmpImmediate := self genJumpCharacterInScratchReg: TempReg].
	classIndex = objectMemory smallFloatTag ifTrue:
		[jmpImmediate := self genJumpSmallFloatInScratchReg: TempReg].
	jmpImmediate jmpTarget: targetFixUp