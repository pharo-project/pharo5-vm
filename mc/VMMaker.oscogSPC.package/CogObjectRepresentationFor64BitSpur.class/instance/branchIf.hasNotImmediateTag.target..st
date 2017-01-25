sista support
branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp
	<var: #targetFixUp type: #'AbstractInstruction *'>
	| jmpImmediate |
	<inline: true>
	classIndex = objectMemory smallIntegerTag ifTrue:
		[jmpImmediate := self genJumpNotSmallInteger: reg].
	classIndex = objectMemory characterTag ifTrue:
		[jmpImmediate := self genJumpNotCharacter: reg].
	classIndex = objectMemory smallFloatTag ifTrue:
		[jmpImmediate := self genJumpNotSmallFloat: reg].
	jmpImmediate jmpTarget: targetFixUp