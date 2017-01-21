sista support
branchIf: reg hasImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate |
	<inline: true>
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpSmallInteger: reg].
	classIndex = objectMemory characterTag ifTrue:
		[jmpImmediate := self genJumpCharacter: reg].
	classIndex = objectMemory smallFloatTag ifTrue:
		[jmpImmediate := self genJumpSmallFloat: reg].
	jmpImmediate jmpTarget: targetFixUp