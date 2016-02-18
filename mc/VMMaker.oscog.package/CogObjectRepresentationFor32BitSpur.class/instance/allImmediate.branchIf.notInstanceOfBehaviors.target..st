sista support
allImmediate: immediateMask branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	| jmpImmediate |
	< inline: true>	
	<var: #targetFixUp type: #'AbstractInstruction *'>
	self assert: immediateMask = objectMemory tagMask.
	jmpImmediate := self genJumpNotImmediate: reg.
	jmpImmediate jmpTarget: targetFixUp.
	^0