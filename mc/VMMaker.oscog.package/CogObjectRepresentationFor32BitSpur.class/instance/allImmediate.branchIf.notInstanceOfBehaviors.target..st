sista support
allImmediate: immediateMask branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	< inline: true>	
	<var: #targetFixUp type: #'AbstractInstruction *'>
	self assert: immediateMask = objectMemory tagMask.
	(self genJumpNotImmediate: reg) jmpTarget: targetFixUp.
	^0